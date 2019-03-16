defmodule MixTest.Tasks.Cck.Compile do
  use ExUnit.Case
  import Dummy

  test "the cck.compile task" do
    dummy IO, ["puts"] do
      Mix.Tasks.Cck.Compile.run("args")
      assert called(IO.puts("Compiling..."))
    end
  end
end
