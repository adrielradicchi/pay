# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pay,
  ecto_repos: [Pay.Repo]

# Configures the endpoint
config :pay, PayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xFUIJr9ZgHXoLejANGav21R+LiEGES5p7kOM/MCxMdYmEx86Ag0CDS4AR77Yl57L",
  render_errors: [view: PayWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Pay.PubSub,
  live_view: [signing_salt: "qliRf8Ns"]

config :pay, Pay.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :pay, :basic_auth,
  username: "pay",
  password: "pay123"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
