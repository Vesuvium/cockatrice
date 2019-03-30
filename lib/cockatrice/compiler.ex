defmodule Cockatrice.Compiler do
  alias Cockatrice.FindFiles
  alias Cockatrice.Page

  def compile() do
    dist_folder = Confex.get_env(:cockatrice, :dist)
    content_folder = Confex.get_env(:cockatrice, :content)
    files = FindFiles.search(content_folder, ".md")

    Enum.each(files, fn file ->
      file
      |> Page.new()
      |> Page.write(dist_folder, file)
    end)
  end
end
