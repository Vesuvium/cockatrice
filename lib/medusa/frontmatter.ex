defmodule Medusa.Frontmatter do
  @moduledoc """
  Parses the frontmatter
  """
  alias Medusa.Yaml

  def parse(string) do
    Enum.reduce(Yaml.read(string), %{}, fn {key, value}, acc ->
      Map.put(acc, key, value)
    end)
  end

  def defaults(frontmatter, defaults) do
    Enum.reduce(defaults, frontmatter, fn {key, value}, acc ->
      if Map.has_key?(acc, key) == false do
        Map.put(acc, key, value)
      else
        acc
      end
    end)
  end
end
