defmodule DraxTest do
  use ExUnit.Case
  doctest Drax

  test "greets the world" do
    assert Drax.hello() == :world
  end
end
