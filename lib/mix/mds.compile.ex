defmodule Mix.Tasks.Mds.Compile do
  @doc """
  Adds mds.compile to mix
  """
  alias Medusa.Compiler

  def run(_args) do
    Compiler.compile()
  end
end
