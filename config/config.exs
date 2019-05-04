use Mix.Config

config :medusa,
  dist: {:system, "MEDUSA_DIST_FOLDER", "dist"},
  content: {:system, "MEDUSA_CONTENT_FOLDER", "content"},
  templates: {:system, "MEDUSA_TEMPLATES_FOLDER", "templates"},
  port: {:system, "MEDUSA_PORT", 4000},
  templating_engine: Medusa.Adapters.Pug

if Mix.env() == :test do
  import_config "#{Mix.env()}.exs"
end
