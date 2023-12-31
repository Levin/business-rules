defmodule TamerTest do
  use ExUnit.Case
  doctest Tamer

  test "greets the world" do
    assert Tamer.hello() == :world
  end
end
