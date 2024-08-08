import Config

config :hyper_text, HyperTextWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "lZjaQPz67LfAkSq/QKBcuUXgqNcmF51/nKkBCOL0a+/eR3iulfGKaNJuajuamPOy",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:hyper_text, ~w(--sourcemap=inline --watch)]}
  ]

config :hyper_text, HyperTextWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"lib/hyper_text_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

config :hyper_text, dev_routes: true

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  debug_heex_annotations: true,
  enable_expensive_runtime_checks: true

config :hyper_text, cache_control: "public, max-age=0"