import Config

config :hyper_text,
  generators: [timestamp_type: :utc_datetime]

config :hyper_text, HyperTextWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: HyperTextWeb.ErrorHTML, json: HyperTextWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: HyperText.PubSub,
  live_view: [signing_salt: "TT5OV6ll"]

config :esbuild,
  version: "0.17.11",
  hyper_text: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"