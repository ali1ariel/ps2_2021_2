# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :black_cat,
  ecto_repos: [BlackCat.Repo]

  config :gettext, :default_locale, "pt_BR"
  config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Configures the endpoint
config :black_cat, BlackCatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dOdDB4cN8K+kJg0LXyPHhL+VjATHwXkTU6PjP0dpWvPP0ZwsRY2MNEAVpojI8WCh",
  render_errors: [view: BlackCatWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BlackCat.PubSub,
  live_view: [signing_salt: "0Qp9NA5+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :black_cat, BlackCat.Mailer, adapter: Swoosh.Adapters.Local

config :black_cat, upload_directory: "./uploads/images"

# Configure esbuild (the version is required)


# https://github.com/CargoSense/dart_sass
config :dart_sass,
  version: "1.49.0",
  default: [
    args: ~w(css/app.scss ../priv/static/assets/css/app.css),
    cd: Path.expand("../assets", __DIR__)
  ]

# Import kaffy config
import_config "kaffy.exs"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
