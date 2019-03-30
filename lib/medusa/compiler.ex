defmodule Medusa.Compiler do
  alias Medusa.FindFiles
  alias Medusa.Page

  def compile() do
    dist_folder = Confex.get_env(:medusa, :dist)
    content_folder = Confex.get_env(:medusa, :content)
    files = FindFiles.search(content_folder, ".md")

    Enum.each(files, fn file ->
      file
      |> Page.new()
      |> Page.write(dist_folder, file)
    end)
  end
end
