defmodule Cockatrice.Page do
  @templating_engine Cockatrice.Adapters.Pug
  alias Cockatrice.Markdown

  @moduledoc """
  Creates and writes pages
  """

  def new(file) do
    templates_folder = Confex.get_env(:cockatrice, :templates)
    config = Application.get_env(:cockatrice, __MODULE__, [])
    engine = config[:templating_engine] || @templating_engine

    file
    |> Markdown.read()
    |> engine.compile("#{templates_folder}/layout.pug")
  end

  def write(page, dist_folder) do
    File.write("#{dist_folder}/index.html", page)
  end
end
