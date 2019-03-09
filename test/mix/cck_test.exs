defmodule MixTest.Tasks.Cck do
  use ExUnit.Case
  import Dummy

  test "welcomes to cockatrice" do
    dummy IO, ["puts"] do
      Mix.Tasks.Cck.run("args")
      assert called(IO.puts("Welcome to cockatrice"))
    end
  end
end
