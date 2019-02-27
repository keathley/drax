defmodule Drax.GCounterTest do
  use ExUnit.Case, async: true
  use PropCheck

  alias Drax.GCounter

  property "counters are commutative" do
    forall [c1, c2] <- [counter(), counter()] do
      GCounter.merge(c1, c2) == GCounter.merge(c2, c1)
    end
  end

  property "counters can be converted to integers" do
    forall {total, counter} <- counter_with_sum() do
      GCounter.to_i(counter) == total
    end
  end

  def counter_with_sum do
    let pairs <- non_empty(list({id(), pos_integer()})) do
      total =
        pairs
        |> Enum.map(fn {_, delta} -> delta end)
        |> Enum.sum

      {total, to_counter(pairs)}
    end
  end

  def counter do
    let pairs <- non_empty(list({id(), pos_integer()})) do
      to_counter(pairs)
    end
  end

  def id do
    frequency([
      {10, :self},
      {90, atom()}
    ])
  end

  def to_counter(list), do: Enum.reduce(list, GCounter.new(), &increment/2)

  def increment({id, delta}, counter), do: GCounter.increment(counter, id, delta)
end
