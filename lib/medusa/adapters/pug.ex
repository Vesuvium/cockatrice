defmodule Medusa.Adapters.Pug do
  @behaviour Medusa.TemplateAdapter
  @moduledoc """
  Pug adapter
  """

  def raw(string) do
    string
  end

  def compile(data, path) do
    path
    |> File.read!()
    |> Expug.to_eex!(raw_helper: "Medusa.Adapters.Pug.raw")
    |> EEx.eval_string(assigns: [page: data])
  end
end
