defmodule Medusa.Cli do
  alias Medusa.Compiler
  alias Medusa.Project
  alias Medusa.Server

  def main(args \\ []) do
    command = Enum.at(args, 0)

    cond do
      command == "compile" -> Compiler.compile()
      command == "server" -> Medusa.Cli.server()
      command == "new" -> Project.new(Enum.at(args, 1))
      command == "version" -> Medusa.Cli.version()
      command == "help" -> Medusa.Cli.help()
      command == nil -> IO.puts("No command provided")
      true -> IO.puts("Unknown command")
    end
  end

  def server() do
    Server.start(1, 2)
  end

  def version() do
    IO.puts("Medusa version #{Application.spec(:medusa, :vsn)}")
  end

  def help() do
    IO.puts(~S(
new NAME    creates a new project
compile     generates html files
server      runs the development server
version     print the version
help        print this text))
  end
end
