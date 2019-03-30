defmodule Cockatrice.MixProject do
  use Mix.Project

  def project do
    [
      app: :cockatrice,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Cockatrice.Server, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:confex, "~> 3.4.0"},
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:earmark, "~> 1.3.1"},
      {:dummy, "~> 1.1.0"},
      {:expug, "~> 0.9"},
      {:phoenix_live_reload, "~> 1.2"},
      {:plug, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"},
      {:yaml_elixir, "~> 2.1.0"}
    ]
  end
end
