defmodule Medusa.Server.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    dist_folder = Confex.get_env(:medusa, :dist)
    send_file(conn, 200, "#{dist_folder}/index.html")
  end

  get "/*glob" do
    dist_folder = Confex.get_env(:medusa, :dist)
    filename = List.last(glob)
    fullpath = Enum.join(glob, "/")

    file =
      if String.contains?(filename, ".") do
        "#{dist_folder}/#{fullpath}"
      else
        "#{dist_folder}/#{fullpath}.html"
      end

    if File.exists?(file) do
      send_file(conn, 200, file)
    else
      send_resp(conn, 404, "oops")
    end
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
