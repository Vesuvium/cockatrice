defmodule Cockatrice.FindFiles do
  @doc """
  File finding utilities
  """

  @doc """
  Search files with a given extension, including nested directories.
  """
  def search(path, extension) do
    expand(File.ls(path), path, extension)
  end

  defp expand({:ok, files}, path, extension) do
    files
    |> Enum.flat_map(&search("#{path}/#{&1}", extension))
  end

  defp expand({:error, _}, path, extension) do
    if String.ends_with?(path, extension) do
      [path]
    else
      []
    end
  end
end
