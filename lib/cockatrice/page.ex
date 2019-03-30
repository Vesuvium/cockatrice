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

  def target(file_path, dist_path) do
    partial =
      file_path
      |> String.split("/", parts: 2)
      |> Enum.at(1)

    "#{dist_path}/#{partial}"
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

  def write(content, dist_path, file_path) do
    file_path
    |> Cockatrice.Page.target(dist_path)
    |> Cockatrice.Page.prepare_path()
    |> File.write(content)
  end
end
