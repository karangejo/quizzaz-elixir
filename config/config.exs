# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :quizzaz,
  ecto_repos: [Quizzaz.Repo]

# Configures the endpoint
config :quizzaz, QuizzazWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1s61wjxyogZlC2b48+wA+H9GeeMK2RFJvage3nYCbF0TBquZs2ed5jYf6+Yhj2CS",
  render_errors: [view: QuizzazWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Quizzaz.PubSub,
  live_view: [signing_salt: "/bO1qB7m"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
