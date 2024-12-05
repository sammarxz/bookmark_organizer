# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :bookmark_organizer,
  ecto_repos: [BookmarkOrganizer.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :bookmark_organizer, BookmarkOrganizerWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: BookmarkOrganizerWeb.ErrorHTML, json: BookmarkOrganizerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: BookmarkOrganizer.PubSub,
  live_view: [signing_salt: "ucq2VGiK"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  bookmark_organizer: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  bookmark_organizer: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :bookmark_organizer, BookmarkOrganizer.Guardian,
  issuer: "bookmark_organizer",
  secret_key: "R6omEWugKqCu8Fw2STGp2bhVJyHUJxR6Xxtb6MatssuGocp31fuZrr9t9C8Hs7PX"
