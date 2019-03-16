defmodule Cockatrice.Server.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_file(conn, 200, "dist/index.html")
  end

  get "/*glob" do
    filename = List.last(glob)
    fullpath = Enum.join(glob, "/")

    file =
      if String.contains?(filename, ".") do
        "dist/#{fullpath}"
      else
        "dist/#{fullpath}.html"
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
