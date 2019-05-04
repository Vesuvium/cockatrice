defmodule Medusa.MixProject do
  use Mix.Project

  def project do
    [
      app: :medusa,
      version: "0.2.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      escript: escript(),
      source_url: "https://github.com/Vesuvium/medusa",
      homepage_url: "https://hexdocs.pm/medusa",
      docs: [
        main: "Medusa",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def escript do
    [main_module: Medusa.Cli]
  end

  defp deps do
    [
      {:confex, "~> 3.4.0"},
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:earmark, "~> 1.3.1"},
      {:dummy, "~> 1.1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:expug, "~> 0.9"},
      {:plug, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"},
      {:yaml_elixir, "~> 2.1.0"}
    ]
  end

  defp description do
    "Static website generator with support for Pug."
  end

  defp package do
    [
      name: :medusa,
      files: ~w(mix.exs lib .formatter.exs README.md LICENSE),
      maintainers: ["Jacopo Cascioli"],
      licenses: ["MPL 2.0"],
      links: %{"GitHub" => "https://github.com/Vesuvium/medusa"}
    ]
  end
end
