defmodule Drax.OrSet do
  @moduledoc """
  An or-set based CRDT
  """

  @opaque pair :: {MapSet.t, MapSet.t}
  @type element :: term()
  @type t :: %{optional(element()) => pair()}

  def new, do: %{}
  def new(list), do: Enum.reduce(list, new(), fn (e, set) -> add(set, e) end)

  def add(set, element, tag \\ Drax.tag()) do
    Map.update set, element, new_pair(tag), fn {adds, removes} ->
      {MapSet.put(adds, tag), removes}
    end
  end

  def equal?(seta, setb) do
  end

  def delete(set, element) do
    case Map.get(set, element) do
      nil ->
        set

      {adds, removes} ->
        Map.put(set, element, {adds, MapSet.union(adds, removes)})
    end
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
