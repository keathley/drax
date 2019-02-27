defmodule Drax.OrSetTest do
  use ExUnit.Case, async: true
  use PropCheck

  alias Drax.OrSet

  property "merging sets is commutative" do
    forall {set1, set2} <- {set(), set()} do
      OrSet.merge(set1, set2) == OrSet.merge(set2, set1)
    end
  end

  def set do
    let items <- non_empty(list(pos_integer())) do
      to_set(items)
    end
  end

  def to_set(list), do: OrSet.new(list)
end

