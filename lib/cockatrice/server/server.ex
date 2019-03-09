defmodule Cockatrice.Server do
  alias Plug.Cowboy
  alias Cockatrice.Server.Router
  require Logger

  def start(_type, _args) do
    children = [
      Cowboy.child_spec(scheme: :http, plug: Router, options: [port: 4001])
    ]

    Logger.info("Starting Cockatrice on http://localhost:4001")
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
