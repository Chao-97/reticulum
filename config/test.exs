import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ret, RetWeb.Endpoint,
  http: [port: 4001],
  allowed_origins: "*",
  # This config value is for local development only.
  secret_key_base: "txlMOtlaY5x3crvOCko4uV5PM29ul3zGo1oBGNO3cDXx+4GHLKqt0gR9qzgThxa5",
  cors_proxy_url: [scheme: "https", host: "hubs-proxy.local", port: 4000],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :ret, Ret.AppConfig, caching?: false

config :ret, Ret.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "ret_test",
  template: "template0",
  pool_size: 10,
  pool: Ecto.Adapters.SQL.Sandbox

config :ret, Ret.SessionLockRepo,
  adapter: Ecto.Adapters.Postgres,
  database: "ret_test",
  template: "template0",
  pool_size: 10,
  pool: Ecto.Adapters.SQL.Sandbox

config :ret, Ret.Locking, lock_timeout_ms: 1000 * 60 * 15

config :ret, Ret.Guardian,
  issuer: "ret",
  # This config value is for local development only.
  secret_key: "47iqPEdWcfE7xRnyaxKDLt9OGEtkQG3SycHBEMOuT2qARmoESnhc76IgCUjaQIwX"

config :ret, Ret.Storage,
  host: "https://hubs.local:4000",
  storage_path: "storage/test",
  ttl: 60 * 60 * 24

config :sentry,
  environment_name: :test,
  json_library: Poison,
  included_environments: [],
  tags: %{
    env: "test"
  }

config :ret, Ret.Repo.Migrations.AdminSchemaInit, postgrest_password: "password"
config :ret, Ret.Locking, lock_timeout_ms: 1000 * 60 * 15
config :ret, Ret.Account, admin_email: "admin@mozilla.com"

config :ret, RetWeb.HubChannel, enable_terminate_actions: false

config :ret, Ret.PermsToken, perms_key: "-----BEGIN RSA PRIVATE KEY-----\nMIICWwIBAAKBgQCtzZwdkJCD95+YAsyB49X5YFTocikPRAQvSuAsaUixMHJsSDW9\nr/Xfd0h8g/WQyRRkTjbbIVwzULfCU2awjNjPK9+9iHewQzqTwJiWLTTUl8JAdVXk\nbDuDU21XYc9j+3bcxxZKfmwJjXBzkXc0AO6q0XJT+pwMaqV7+lzDEdfaLQIDAQAB\nAoGAGV0UF0xtipSseaaO6bWyGD5ypaljTJMEeVJX/KMwtIr5Z8vx68it/PqPXXx0\nbbiqfSjc4IWxyttQtc8uAT3MtdBvBiAN6GempHiupdCZ7CSSG4e3D4Yvkip0QCOd\nqiSiAGbnq97u2Sc85PDpKPjqfX+TKil6dw9HT+gYDeHzbpECQQD+ZvqsVti+/1jY\n9XBmgctnpNPABXnayxsjPJA78gsEoV1fptKWwrBkrFjxqduBUpbUeOoYwEa6mF16\nOU5a85UHAkEAruULsN8yYCzFylL+ZSrTRBOSWPO3MhDJI0cV9CMAduI2Cb+x+SXd\nwshGXeYilm35YUeG4WnWV/pMBTmsVhEeKwJAcRPA1B1+FddV3ImrvkRu7tCatj04\n3oFsvIrM6Xg6YYKACGYUMKK02OqqVjBTuvXEyQg9tWaxiXr0AcG7DD48vQJARQ5x\nWEw44tqq2mF8y0tmkcm8jlzk5+LS2JgX5gbwBwD4306Oola+Qku75RWacJVJ04xf\niJ+2n5RX8fQ8xNsLcwJAXI6FVu+1ihttzNaXl9UYQiQOHmvtbb/xqYUCaIVmw/Yi\nXcSi3pENA6dka5C4hQlE8M6eArfxBvagRzGlrdqsGQ==\n-----END RSA PRIVATE KEY-----"

config :ret, Ret.MediaResolver,
  giphy_api_key: nil,
  deviantart_client_id: nil,
  deviantart_client_secret: nil,
  imgur_mashape_api_key: nil,
  imgur_client_id: nil,
  youtube_api_key: nil,
  sketchfab_api_key: nil,
  ytdl_host: nil,
  photomnemonic_endpoint: "https://uvnsm9nzhe.execute-api.us-west-1.amazonaws.com/public"

config :ret, :ex_unit_configuration, exclude: [dev_only: true]

config :ret, RetWeb.Plugs.RateLimit, throttle?: false
