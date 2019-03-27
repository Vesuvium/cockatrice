defmodule Cockatrice.Page do
  @moduledoc """
  Creates and writes pages
  """

  def write(page, dist_folder) do
    File.write("#{dist_folder}/index.html", page)
  end
end
