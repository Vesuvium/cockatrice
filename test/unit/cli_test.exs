defmodule MedusaTest.Cli do
  use ExUnit.Case
  import Dummy

  alias Medusa.Cli
  alias Medusa.Compiler
  alias Medusa.Project
  alias Medusa.Server

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

  test "the version command" do
    dummy Cli, [{"version", fn -> nil end}] do
      Cli.main(["version"])
      assert called(Cli.version())
    end
  end

  test "the version function" do
    dummy IO, ["puts"] do
      version = Application.spec(:medusa, :vsn)
      assert Cli.version() == "Medusa version #{version}"
    end
  end

  test "the help function" do
    dummy IO, ["puts"] do
      assert Cli.help() ==
               ~S(
new NAME    creates a new project
compile     generates html files
server      runs the development server
version     print the version
help        print this text)
    end
  end

  test "the compile command" do
    dummy Compiler, [{"compile", fn -> "done" end}] do
      assert Cli.main(["compile"]) == "done"
    end
  end

  test "the server command" do
    dummy Cli, [{"server", fn -> nil end}] do
      Cli.main(["server"])
      assert called(Cli.server())
    end
  end

  test "the server function" do
    dummy Server, ["start/2"] do
      Cli.server()
      assert called(Server.start(1, 2))
    end
  end

  test "the new command" do
    dummy Project, ["new"] do
      Cli.main(["new", "app"])
      assert called(Project.new("app"))
    end
  end
end
