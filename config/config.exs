use Mix.Config

config :cockatrice,
  dist: {:system, "COCKATRICE_DIST_FOLDER", "dist"},
  port: {:system, "COCKATRICE_PORT", 4000}

if Mix.env() == :test do
  import_config "#{Mix.env()}.exs"
end
