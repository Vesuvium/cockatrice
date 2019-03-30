defmodule Medusa.Content do
  alias Medusa.Frontmatter

  defp merge([front, markdown]) do
    Frontmatter.parse(front) |> Map.put("content", Earmark.as_html!(markdown))
  end

  def extract(string) do
    String.split(string, ~r/\n-{3,}\n/, parts: 2)
  end

  def read(path) do
    path |> File.read!() |> extract() |> merge() |> Frontmatter.defaults(layout: "page.pug")
  end
end
