defmodule MedusaTest.Server.Router do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Medusa.Server.Router

  @opts Router.init([])

  setup_all do
    dist = Application.get_env(:medusa, :dist)
    File.mkdir_p("#{dist}/folder")
    File.mkdir_p("#{dist}/css")
    File.write("#{dist}/index.html", "index")
    File.write("#{dist}/page.html", "page")
    File.write("#{dist}/folder/page.html", "nested")
    File.write("#{dist}/favicon.ico", "favicon")
    File.write("#{dist}/css/main.css", "css")

    on_exit(fn -> File.rm_rf(dist) end)
  end

  test "a root request" do
    conn = conn(:get, "/")
    conn = Router.call(conn, @opts)
    assert conn.state == :file
    assert conn.status == 200
    assert conn.resp_body == "index"
  end

  test "an index.html request" do
    conn = conn(:get, "/index.html")
    conn = Router.call(conn, @opts)
    assert conn.state == :file
    assert conn.status == 200
    assert conn.resp_body == "index"
  end

  test "a page request" do
    conn = conn(:get, "/page")
    conn = Router.call(conn, @opts)
    assert conn.state == :file
    assert conn.status == 200
    assert conn.resp_body == "page"
  end

  test "a nested page request" do
    conn = conn(:get, "/folder/page")
    conn = Router.call(conn, @opts)
    assert conn.state == :file
    assert conn.status == 200
    assert conn.resp_body == "nested"
  end

  test "a static resource" do
    conn = conn(:get, "/favicon.ico")
    conn = Router.call(conn, @opts)
    assert conn.state == :file
    assert conn.status == 200
    assert conn.resp_body == "favicon"
  end

  test "a nested static resource" do
    conn = conn(:get, "/css/main.css")
    conn = Router.call(conn, @opts)
    assert conn.state == :file
    assert conn.status == 200
    assert conn.resp_body == "css"
  end

  test "a 404 request" do
    conn = conn(:get, "/whatever")
    conn = Router.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "oops"
  end
end
