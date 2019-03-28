defmodule Mix.Tasks.Cck.Compile do
  @doc """
  Adds cck.compile to mix
  """
  alias Cockatrice.Compiler

  def run(_args) do
    Compiler.compile()
  end
end
