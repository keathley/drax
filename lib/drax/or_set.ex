defmodule Drax.OrSet do
  @moduledoc """
  An or-set based CRDT. Adds take precedence over deletions during merges.
  """

  @opaque pair :: {MapSet.t, MapSet.t}
  @opaque element :: term()
  @opaque t :: %{optional(element()) => pair()}

  def new, do: %{}
  def new(list), do: Enum.reduce(list, new(), fn (e, set) -> add(set, e) end)

  @doc """
  Adds a new element to the set
  """
  def add(set, element, tag \\ Drax.tag()) do
    Map.update set, element, new_pair(tag), fn {adds, removes} ->
      {MapSet.put(adds, tag), removes}
    end
  end

  @doc """
  Deletes an element from the set
  """
  def delete(set, element) do
    case Map.get(set, element) do
      nil ->
        set

      {adds, removes} ->
        Map.put(set, element, {adds, MapSet.union(adds, removes)})
    end
  end

  @doc """
  Checks equality between 2 sets. This equality is strict and only returns true
  if all keys contain the same additions and deletions.
  """
  def equal?(seta, setb) do
    IO.inspect([seta, setb], label: "Checking equality")
    Map.equal?(seta, setb)
  end


  @doc """
  Merges a set together. Its possible that after this operation returns
  elements may be re-added to the set.
  """
  def merge(a, b) do
    Map.merge(a, b, &merge_pairs/3)
  end

  defp merge_pairs(_k, {a_adds, a_removes}, {b_adds, b_removes}) do
    {MapSet.union(a_adds, b_adds), MapSet.union(a_removes, b_removes)}
  end

  def to_list(set) do
    set
    |> Enum.reduce([], &add_element_to_list/2)
    |> Enum.reverse
  end

  defp add_element_to_list({e, {adds, removes}}, list) do
    if element_removed?(adds, removes) do
      list
    else
      [e | list]
    end
  end

  defp element_removed?(adds, removes) do
    adds
    |> MapSet.difference(removes)
    |> MapSet.size == 0
  end

  defp new_pair(tag), do: {MapSet.new([tag]), MapSet.new()}
end
