# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :todo,
  ecto_repos: [Todo.Repo],
  generators: [timestamp_type: :utc_datetime]

config :todo, Todo.Repo,
  migration_primary_key: [type: :binary_id],
  migration_timestamps: [inserted_at: :created_at]

config :pbkdf2_elixir, rounds: 12

config :todo, TodoWeb.Auth.Guardian,
  issuer: "todo_app",
  secret_key: System.get_env("JWT_SECRET_KEY")

config :todo, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: TodoWeb.Router,
      endpoint: TodoWeb.Endpoint
    ]
  }

config :phoenix_swagger, json_library: Jason

# Configures the endpoint
config :todo, TodoWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: TodoWeb.ErrorHTML, json: TodoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Todo.PubSub,
  live_view: [signing_salt: "fvWZI06B"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  todo: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  todo: [
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
