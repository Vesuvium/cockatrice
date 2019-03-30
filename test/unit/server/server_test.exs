defmodule CockatriceTest.Server do
  use ExUnit.Case
  import Dummy

  alias Cockatrice.Server

  test "the children function" do
    dummy Plug.Cowboy, ["child_spec"] do
      result = [
        [scheme: :http, plug: Cockatrice.Server.Router, options: [port: 4000]]
      ]

      assert Server.children() == result
    end
  end

  test "the start function" do
    dummy Supervisor, ["start_link/2"] do
      result = Supervisor.start_link(Server.children(), strategy: :one_for_one)
      assert Server.start("", "") == result
    end
  end
end
