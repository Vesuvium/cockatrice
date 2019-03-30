defmodule CockatriceTest.Cli do
  use ExUnit.Case
  import Dummy

  alias Cockatrice.Cli
  alias Cockatrice.Compiler

  test "running the cli without commands" do
    dummy IO, ["puts"] do
      assert Cli.main() == "No command provided"
    end
  end

  test "running an unknown command" do
    dummy IO, ["puts"] do
      assert Cli.main(["whatever"]) == "Unknown command"
    end
  end

  test "the compile command" do
    dummy Compiler, [{"compile", fn -> "done" end}] do
      assert Cli.main(["compile"]) == "done"
    end
  end
end
