defmodule MixTest.Cck.Server do
  use ExUnit.Case
  import Dummy

  test "the cck.server task" do
    dummy Mix.Tasks.Run, ["run"] do
      Mix.Tasks.Cck.Server.run([])
      assert called(Mix.Tasks.Run.run(["--no-halt"]))
    end
  end
end
