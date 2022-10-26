import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :liveview_client, LiveviewClientWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "GxrBw7m7GP+Y0xNxpTPmf98q6tqRGPDK9bjaFwdnzgmF6zYgeZUGJ2T0oDtaV4WY",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
