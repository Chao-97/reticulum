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

# config :ret, Ret.PermsToken, perms_key: "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC7VJTUt9Us8cKj\nMzEfYyjiWA4R4/M2bS1GB4t7NXp98C3SC6dVMvDuictGeurT8jNbvJZHtCSuYEvu\nNMoSfm76oqFvAp8Gy0iz5sxjZmSnXyCdPEovGhLa0VzMaQ8s+CLOyS56YyCFGeJZ\nqgtzJ6GR3eqoYSW9b9UMvkBpZODSctWSNGj3P7jRFDO5VoTwCQAWbFnOjDfH5Ulg\np2PKSQnSJP3AJLQNFNe7br1XbrhV//eO+t51mIpGSDCUv3E0DDFcWDTH9cXDTTlR\nZVEiR2BwpZOOkE/Z0/BVnhZYL71oZV34bKfWjQIt6V/isSMahdsAASACp4ZTGtwi\nVuNd9tybAgMBAAECggEBAKTmjaS6tkK8BlPXClTQ2vpz/N6uxDeS35mXpqasqskV\nlaAidgg/sWqpjXDbXr93otIMLlWsM+X0CqMDgSXKejLS2jx4GDjI1ZTXg++0AMJ8\nsJ74pWzVDOfmCEQ/7wXs3+cbnXhKriO8Z036q92Qc1+N87SI38nkGa0ABH9CN83H\nmQqt4fB7UdHzuIRe/me2PGhIq5ZBzj6h3BpoPGzEP+x3l9YmK8t/1cN0pqI+dQwY\ndgfGjackLu/2qH80MCF7IyQaseZUOJyKrCLtSD/Iixv/hzDEUPfOCjFDgTpzf3cw\nta8+oE4wHCo1iI1/4TlPkwmXx4qSXtmw4aQPz7IDQvECgYEA8KNThCO2gsC2I9PQ\nDM/8Cw0O983WCDY+oi+7JPiNAJwv5DYBqEZB1QYdj06YD16XlC/HAZMsMku1na2T\nN0driwenQQWzoev3g2S7gRDoS/FCJSI3jJ+kjgtaA7Qmzlgk1TxODN+G1H91HW7t\n0l7VnL27IWyYo2qRRK3jzxqUiPUCgYEAx0oQs2reBQGMVZnApD1jeq7n4MvNLcPv\nt8b/eU9iUv6Y4Mj0Suo/AU8lYZXm8ubbqAlwz2VSVunD2tOplHyMUrtCtObAfVDU\nAhCndKaA9gApgfb3xw1IKbuQ1u4IF1FJl3VtumfQn//LiH1B3rXhcdyo3/vIttEk\n48RakUKClU8CgYEAzV7W3COOlDDcQd935DdtKBFRAPRPAlspQUnzMi5eSHMD/ISL\nDY5IiQHbIH83D4bvXq0X7qQoSBSNP7Dvv3HYuqMhf0DaegrlBuJllFVVq9qPVRnK\nxt1Il2HgxOBvbhOT+9in1BzA+YJ99UzC85O0Qz06A+CmtHEy4aZ2kj5hHjECgYEA\nmNS4+A8Fkss8Js1RieK2LniBxMgmYml3pfVLKGnzmng7H2+cwPLhPIzIuwytXywh\n2bzbsYEfYx3EoEVgMEpPhoarQnYPukrJO4gwE2o5Te6T5mJSZGlQJQj9q4ZB2Dfz\net6INsK0oG8XVGXSpQvQh3RUYekCZQkBBFcpqWpbIEsCgYAnM3DQf3FJoSnXaMhr\nVBIovic5l0xFkEHskAjFTevO86Fsz1C2aSeRKSqGFoOQ0tmJzBEs1R6KqnHInicD\nTQrKhArgLXX4v3CddjfTRJkFWDbE/CkvKZNOrcf1nhaGCPspRJj2KUkj1Fhl9Cnc\ndn/RsYEONbwQSjIfMPkvxF+8HQ==\n-----END PRIVATE KEY-----"
config :ret, Ret.PermsToken, perms_key: "-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQCt+VJDI3yfGUChntSDVBSeK8lFoWVtzBIQykfsx5zl/yVK8LkL\nftmUEq2436XHMoUXLfycZkGZnIlr9WdFDvfowOTCSu1KrfHkgdHQuHoo/nt13FfL\ngb5VJmNxX85v5Hl+Nc/g55To1HKPkwVnDdqZ3dOWI7w5UiAkLUrfFAuu/QIDAQAB\nAoGAL2nknoGcZCvYrnOADW6r09OxHfX3k63rOoI2ifR48UHRIxRqChT/LVjN2bWy\nE5DULtYMo39G35uG5FJUW8DRlTv8czubdMWpVmXeb9QwRQEzePZOdDcl+9Pr3xKd\n0tNLtusQ3NkXpWfi/Bn1r7+P3KcQG0/iRteguSaWdrUuS6ECQQD3/yzGXUfCFs+V\nlx9G3yVf8CBsjb8VAMoNgN3yz1I5De+pPWMNqEuMWfRobwcnxpOuO5L5a8Gd1D3U\nMf6oI9RpAkEAs5abSwyPFMKkrch+Lir0690LFKtEr+bLNat689eM/ddHpbrIWrZx\ndVM+ANa0cepl+Uo1Pp2YzOI2To2+L29jdQJAKf7iPC0rq6hlOrW+rCe5kod9ViSi\nyRG7JZI/A5EsIVFE1mn4ziVDtd69zrmOgqPT+ltIRkiDHxED710P/LUkkQJANNzB\nK28v8sF0rf7VPYvBemgfad8cIdcCu/KVB4/MXa/v1BXOAf2wGgP9vUt15A5GJAI2\n+A51uuFfcPICKH5WPQJBAJ1ZuK956dIpCb3SMTNYfLX600FWtsxaseu/Q6cxt+UN\nvpNwhHVPR06zaZHErq4FiWk2QlwnAc03yccRYSjT0E4=\n-----END RSA PRIVATE KEY-----"

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
