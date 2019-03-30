defmodule Cockatrice.Page do
  @moduledoc """
  Creates and writes pages
  """

  @templating_engine Cockatrice.Adapters.Pug
  alias Cockatrice.Content

  def new(file) do
    templates_folder = Confex.get_env(:cockatrice, :templates)
    config = Application.get_env(:cockatrice, __MODULE__, [])
    engine = config[:templating_engine] || @templating_engine

    content = Content.read(file)

    content
    |> engine.compile("#{templates_folder}/#{content[:layout]}")
  end

  def write(page, dist_folder) do
    File.write("#{dist_folder}/index.html", page)
  end
end
