# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :exhub,
  ecto_repos: [Exhub.Repo]

config :exhub, Exhub.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :exhub, ExhubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "e2SGyc1BpdsN3ALBeZvSgJG8DCv6py3q6Ik/4USnmTS8AopGM15NW3+L+i5zQ916",
  render_errors: [view: ExhubWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Exhub.PubSub,
  live_view: [signing_salt: "06W6i9nQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"


# Guardian
config :exhub, ExhubWeb.Auth.Guardian,
  issuer: "exhub",
  secret_key: "LO5sTXJAS6b2TK73cwArRznWE0T0BMtqWsQozPvYVxhOBnRsK/dEy0hyiTe73rct"

config :exhub, ExhubWeb.Auth.Pipeline,
  module: ExhubWeb.Auth.Guardian,
  error_handler: ExhubWeb.Auth.ErrorHandler
