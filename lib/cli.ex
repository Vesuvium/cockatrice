defmodule Cockatrice.Cli do
  alias Cockatrice.Compiler
  alias Cockatrice.Server

  def main(args \\ []) do
    command = Enum.at(args, 0)

    cond do
      command == "compile" -> Compiler.compile()
      command == "server" -> Cockatrice.Cli.server()
      command == "version" -> Cockatrice.Cli.version()
      command == "help" -> Cockatrice.Cli.help()
      command == nil -> IO.puts("No command provided")
      true -> IO.puts("Unknown command")
    end
  end

  def server() do
    Server.start(1, 2)
  end

  def version() do
    IO.puts("Cockatrice version #{Application.spec(:cockatrice, :vsn)}")
  end

  def help() do
    IO.puts(~S(
compile     generates html files
server      runs the development server
version     print the version
help        print this text))
  end
end
