use Mix.Config

config :cockatrice,
  dist: {:system, "COCKATRICE_DIST_FOLDER", "dist"}

if Mix.env() == :test do
  import_config "#{Mix.env()}.exs"
end
