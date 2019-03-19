defmodule Cockatrice.Adapters.Pug do
  @behaviour Cockatrice.TemplateAdapter
  @moduledoc """
  Pug adapter
  """

  def raw(string) do
    string
  end

  def compile(data, path) do
    path
    |> File.read!()
    |> Expug.to_eex!(raw_helper: "Cockatrice.Pug.raw")
    |> EEx.eval_string(assigns: [page: data])
  end
end
