defmodule MixTest.Cck.Server do
  use ExUnit.Case
  import Dummy

  test "the cck.server task" do
    dummy IO, ["puts"] do
      Mix.Tasks.Cck.Server.run("args")
      assert called(IO.puts("Server started"))
    end
  end
end
