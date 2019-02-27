defmodule Drax.GCounter do
  @moduledoc """
  Grow only counter CRDT.
  """

  @doc """
  Returns a new counter
  """
  def new(), do: %{}

  @doc """
  Increments the counter for this node by the given delta. If this is the first
  increment operation for this node then the count defaults to the delta.
  """
  def increment(counter, node \\ 1, delta \\ 1) when delta >= 0 do
    Map.update(counter, node, delta, & &1 + delta)
  end

  @doc """
  Merges 2 counters together taking the highest value seen for each node.
  """
  def merge(c1, c2) do
    Map.merge(c1, c2, fn _k, v1, v2 ->  max(v1, v2) end)
  end

  @doc """
  Convert a counter to an integer.
  """
  def to_i(counter) do
    counter
    |> Map.values
    |> Enum.sum
  end

  @doc """
  Determine if a counter is equivalent to another counter or an integer
  """
  def equal(c1, num) when is_integer(num), do: to_i(c1) == num
  def equal(c1, c2), do: c1 == c2
end

