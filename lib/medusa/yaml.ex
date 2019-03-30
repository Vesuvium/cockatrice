defmodule Medusa.Yaml do
  @doc """
  Wrapper for YamlElixir which exposes a simpler interface and handles errors.
  """

  def read(string) do
    case YamlElixir.read_from_string(string) do
      {:ok, yaml} ->
        yaml

      {:error, _error} ->
        nil
    end
  end
end
