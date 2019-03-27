defmodule Cockatrice.Markdown do
  alias Cockatrice.Yaml

  defp parse(data) do
    [frontmatter, markdown] = String.split(data, ~r/\n-{3,}\n/, parts: 2)
    page = %{"content" => Earmark.as_html!(markdown)}

    Enum.reduce(Yaml.read(frontmatter), page, fn {key, value}, acc ->
      Map.put(acc, key, value)
    end)
  end

  def read(path) do
    path |> File.read!() |> parse()
  end
end
