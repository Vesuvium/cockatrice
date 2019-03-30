defmodule Cockatrice.Cli do
  alias Cockatrice.Compiler

  def main(args \\ []) do
    command = Enum.at(args, 0)

    cond do
      command == "compile" -> Compiler.compile()
      command == "version" -> IO.puts("Cockatrice version #{Application.spec(:cockatrice, :vsn)}")
      command == nil -> IO.puts("No command provided")
      true -> IO.puts("Unknown command")
    end
  end
end
