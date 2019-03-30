defmodule Medusa.Page do
  @moduledoc """
  Creates and writes pages
  """

  @templating_engine Medusa.Adapters.Pug
  alias Medusa.Content

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
  Prepares a path by creating the necessary folders, if they don't exist.
  """
  def prepare_path(target) do
    shards = String.split(target, "/")

    Enum.take(shards, Enum.count(shards) - 1)
    |> Enum.join("/")
    |> File.mkdir_p!()

    target
  end

  @doc """
  Writes content for a file in the given dist.
  """
  def write(content, dist_path, file_path) do
    file_path
    |> Medusa.Page.target(dist_path)
    |> Medusa.Page.prepare_path()
    |> File.write(content)
  end
end
