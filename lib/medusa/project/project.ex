defmodule Medusa.Project do
  @moduledoc """
  Manages projects files
  """
  alias Medusa.Files
  alias Medusa.Project.Skeletons

  def init_templates(name) do
    Files.write("#{name}/templates/page.pug", Skeletons.page_template())
  end

  def init_content(name) do
    Files.write("#{name}/content/index.md", Skeletons.content_index(name))
  end

  @doc """
  Creates a new project
  """
  def new(name) do
    Medusa.Project.init_templates(name)
    Medusa.Project.init_content(name)
  end
end
