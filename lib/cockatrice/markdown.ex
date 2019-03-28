defmodule Cockatrice.Markdown do
  alias Cockatrice.Yaml

  defp merge([front, markdown]) do
    frontmatter(front) |> Map.put("content", Earmark.as_html!(markdown))
  end

  def extract(string) do
    String.split(string, ~r/\n-{3,}\n/, parts: 2)
  end

  def frontmatter(string) do
    Enum.reduce(Yaml.read(string), %{}, fn {key, value}, acc ->
      Map.put(acc, key, value)
    end)
  end

  def read(path) do
    path |> File.read!() |> extract() |> merge()
  end
end
