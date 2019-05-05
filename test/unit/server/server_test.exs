defmodule MedusaTest.Server do
  use ExUnit.Case
  import Dummy

  alias Medusa.Server

  test "the children function" do
    dummy Plug.Cowboy, ["child_spec"] do
      result = [
        [scheme: :http, plug: Medusa.Server.Router, options: [port: 4000]]
      ]

      assert Server.children() == result
    end
  end

  test "the start function" do
    dummy Supervisor, ["start_link/2"] do
      dummy Server, [{"loop", fn -> "loop" end}, {"children", fn -> "children" end}] do
        result = Server.start("", "")
        options = [strategy: :one_for_one, name: Medusa.Supervisor]
        assert called(Supervisor.start_link("children", options))

        assert result == "loop"
      end
    end
  end
end
