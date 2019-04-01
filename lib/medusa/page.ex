defmodule Medusa.Page do
  @moduledoc """
  Creates and writes pages
  """

  @templating_engine Medusa.Adapters.Pug

  alias Medusa.Content
  alias Medusa.Files

  @doc """
  Creates a new page by reading the given file and compiling it with the
  templating engine.
  """
  def new(file) do
    templates_folder = Confex.get_env(:medusa, :templates)
    config = Application.get_env(:medusa, __MODULE__, [])
    engine = config[:templating_engine] || @templating_engine

    content = Content.read(file)

    content
    |> engine.compile("#{templates_folder}/#{content[:layout]}")
  end

  @doc """
  Builds the target path using the file path and the dist folder
  """
  def target(file_path, dist_path) do
    partial =
      file_path
      |> String.split("/", parts: 2)
      |> Enum.at(1)
      |> String.split(".")
      |> Enum.at(0)

    "#{dist_path}/#{partial}.html"
  end

  @doc """
  Writes content for a file in the given dist.
  """
  def write(content, dist_path, file_path) do
    file_path
    |> Medusa.Page.target(dist_path)
    |> Files.write(content)
  end
end
