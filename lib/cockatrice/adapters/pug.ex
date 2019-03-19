defmodule Cockatrice.Adapters.Pug do
  @behaviour Cockatrice.TemplateAdapter
  @doc """
  Pug adapter
  """

  def raw(string) do
    string
  end

  def compile(data, path) do
    File.read!(path)
    |> Expug.to_eex!(raw_helper: "Cockatrice.Pug.raw")
    |> EEx.eval_string(assigns: [page: data])
  end
end
