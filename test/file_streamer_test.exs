defmodule FileStreamerTest do
  use ExUnit.Case
  doctest FileStreamer

  test "greets the world" do
    assert FileStreamer.hello() == :world
  end
end
