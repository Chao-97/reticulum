import Config

# Production Config from
# https://github.com/albirrkarim/mozilla-hubs-installation-detailed

# Change this
host = "hubs.lookfoto.cc"
db_name = "ret_dev"
storage_outside_github_workflow = "/home/admin/app/reticulum/storage"

# Dont change this
cors_proxy_host = "hubs-proxy.local"
assets_host = "hubs-assets.local"
link_host = "hubs-link.local"

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :ret, RetWeb.Endpoint,
  url: [scheme: "https", host: host, port: 443],
  static_url: [scheme: "https", host: host, port: 443],
  https: [
    port: 4000,
    otp_app: :ret,
    cipher_suite: :strong,
    keyfile: "/etc/letsencrypt/live/#{host}/privkey.pem",
    certfile: "/etc/letsencrypt/live/#{host}/cert.pem"
  ],
  cors_proxy_url: [scheme: "https", host: cors_proxy_host, port: 443],
  assets_url: [scheme: "https", host: assets_host, port: 443],
  link_url: [scheme: "https", host: link_host, port: 443],
  imgproxy_url: [scheme: "http", host: host, port: 5000],
  debug_errors: true,
  # this is important
  code_reloader: false,
  check_origin: false,
  # This config value is for local development only.
  secret_key_base: "GjVxp/kSkMcrusIy/sHllfNy4ax34uhlf/nGhcQum7HwMdYTtnuAiFDYaGWag+c4",
  allowed_origins: "*",
  allow_crawlers: true

# Configure your database
config :ret, Ret.Repo,
  username: "postgres",
  password: "Pp232400!!",
  database: db_name,
  hostname: "localhost",
  template: "template0",
  pool_size: 10

config :ret, Ret.SessionLockRepo,
  username: "postgres",
  password: "Pp232400!!",
  database: db_name,
  hostname: "localhost",
  template: "template0",
  pool_size: 10

config :ret, Ret.Locking,
  lock_timeout_ms: 1000 * 60 * 15,
  session_lock_db: [
    username: "postgres",
    password: "Pp232400!!",
    database: db_name,
    hostname: "localhost"
  ]

# Place the storage outside github workflow
config :ret, Ret.Storage,
  host: "https://#{host}:4000",
  storage_path: storage_outside_github_workflow,
  ttl: 60 * 60 * 24

config :ret, Ret.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtpdm.aliyun.com",
  port: 25,
  username: "lookfoto@lookfoto.cc",
  password: "ABcd123456",
  tls: :if_available,
  ssl: true,
  retries: 1,
  debug_mode: true

config :ret, RetWeb.Email, from: "lookfoto@lookfoto.cc"

# config :ret, Ret.PermsToken, perms_key: (System.get_env("PERMS_KEY") || "") |> String.replace("\\n", "\n")
config :ret, Ret.PermsToken, perms_key: "-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQCt+VJDI3yfGUChntSDVBSeK8lFoWVtzBIQykfsx5zl/yVK8LkL\nftmUEq2436XHMoUXLfycZkGZnIlr9WdFDvfowOTCSu1KrfHkgdHQuHoo/nt13FfL\ngb5VJmNxX85v5Hl+Nc/g55To1HKPkwVnDdqZ3dOWI7w5UiAkLUrfFAuu/QIDAQAB\nAoGAL2nknoGcZCvYrnOADW6r09OxHfX3k63rOoI2ifR48UHRIxRqChT/LVjN2bWy\nE5DULtYMo39G35uG5FJUW8DRlTv8czubdMWpVmXeb9QwRQEzePZOdDcl+9Pr3xKd\n0tNLtusQ3NkXpWfi/Bn1r7+P3KcQG0/iRteguSaWdrUuS6ECQQD3/yzGXUfCFs+V\nlx9G3yVf8CBsjb8VAMoNgN3yz1I5De+pPWMNqEuMWfRobwcnxpOuO5L5a8Gd1D3U\nMf6oI9RpAkEAs5abSwyPFMKkrch+Lir0690LFKtEr+bLNat689eM/ddHpbrIWrZx\ndVM+ANa0cepl+Uo1Pp2YzOI2To2+L29jdQJAKf7iPC0rq6hlOrW+rCe5kod9ViSi\nyRG7JZI/A5EsIVFE1mn4ziVDtd69zrmOgqPT+ltIRkiDHxED710P/LUkkQJANNzB\nK28v8sF0rf7VPYvBemgfad8cIdcCu/KVB4/MXa/v1BXOAf2wGgP9vUt15A5GJAI2\n+A51uuFfcPICKH5WPQJBAJ1ZuK956dIpCb3SMTNYfLX600FWtsxaseu/Q6cxt+UN\nvpNwhHVPR06zaZHErq4FiWk2QlwnAc03yccRYSjT0E4=\n-----END RSA PRIVATE KEY-----"

# config :ret, Ret.PermsToken, perms_key: "-----BEGIN RSA PRIVATE KEY-----\nMIICWwIBAAKBgQCtzZwdkJCD95+YAsyB49X5YFTocikPRAQvSuAsaUixMHJsSDW9\nr/Xfd0h8g/WQyRRkTjbbIVwzULfCU2awjNjPK9+9iHewQzqTwJiWLTTUl8JAdVXk\nbDuDU21XYc9j+3bcxxZKfmwJjXBzkXc0AO6q0XJT+pwMaqV7+lzDEdfaLQIDAQAB\nAoGAGV0UF0xtipSseaaO6bWyGD5ypaljTJMEeVJX/KMwtIr5Z8vx68it/PqPXXx0\nbbiqfSjc4IWxyttQtc8uAT3MtdBvBiAN6GempHiupdCZ7CSSG4e3D4Yvkip0QCOd\nqiSiAGbnq97u2Sc85PDpKPjqfX+TKil6dw9HT+gYDeHzbpECQQD+ZvqsVti+/1jY\n9XBmgctnpNPABXnayxsjPJA78gsEoV1fptKWwrBkrFjxqduBUpbUeOoYwEa6mF16\nOU5a85UHAkEAruULsN8yYCzFylL+ZSrTRBOSWPO3MhDJI0cV9CMAduI2Cb+x+SXd\nwshGXeYilm35YUeG4WnWV/pMBTmsVhEeKwJAcRPA1B1+FddV3ImrvkRu7tCatj04\n3oFsvIrM6Xg6YYKACGYUMKK02OqqVjBTuvXEyQg9tWaxiXr0AcG7DD48vQJARQ5x\nWEw44tqq2mF8y0tmkcm8jlzk5+LS2JgX5gbwBwD4306Oola+Qku75RWacJVJ04xf\niJ+2n5RX8fQ8xNsLcwJAXI6FVu+1ihttzNaXl9UYQiQOHmvtbb/xqYUCaIVmw/Yi\nXcSi3pENA6dka5C4hQlE8M6eArfxBvagRzGlrdqsGQ==\n-----END RSA PRIVATE KEY-----"
# config :ret, Ret.JanusLoadStatus, default_janus_host: host, janus_port: 443
config :ret, Ret.JanusLoadStatus, default_janus_host: host, janus_port: 4443

# Do not include metadata nor timestamps in development logs
# config :logger, :console, format: "[$level] $message\n"
# Do not print debug messages in production
config :logger, level: :info
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

config :ret, RetWeb.Plugs.HeaderAuthorization,
  header_name: "x-ret-admin-access-key",
  header_value: "admin-only"

config :ret, Ret.SlackClient,
  client_id: "",
  client_secret: "",
  bot_token: ""

# Token is our randomly generated auth token to append to Slacks slash command
# As a query param "token"
config :ret, RetWeb.Api.V1.SlackController, token: ""

config :ret, Ret.DiscordClient,
  client_id: "",
  client_secret: "",
  bot_token: ""

# Allow any origin for API access in dev
config :cors_plug, origin: ["*"]

config :ret,
  # This config value is for local development only.
  upload_encryption_key: "a8dedeb57adafa7821027d546f016efef5a501bd",
  bot_access_key: ""

config :ret, Ret.PageOriginWarmer,
  hubs_page_origin: "https://#{host}:8080",
  admin_page_origin: "https://#{host}:8989",
  spoke_page_origin: "https://#{host}:9090",
  insecure_ssl: true

# config :ret, Ret.HttpUtils, insecure_ssl: true

config :ret, Ret.Scheduler,
  jobs: [
    # Send stats to StatsD every 5 seconds
    {{:extended, "*/5 * * * *"}, {Ret.StatsJob, :send_statsd_gauges, []}},

    # Flush stats to db every 5 minutes
    {{:cron, "*/5 * * * *"}, {Ret.StatsJob, :save_node_stats, []}},

    # Keep database warm when connected users
    {{:cron, "*/3 * * * *"}, {Ret.DbWarmerJob, :warm_db_if_has_ccu, []}},

    # Rotate TURN secrets if enabled
    {{:cron, "*/5 * * * *"}, {Ret.Coturn, :rotate_secrets, []}},

    # Various maintenence routines
    {{:cron, "0 10 * * *"}, {Ret.Storage, :vacuum, []}},
    {{:cron, "3 10 * * *"}, {Ret.Storage, :demote_inactive_owned_files, []}},
    {{:cron, "4 10 * * *"}, {Ret.LoginToken, :expire_stale, []}},
    {{:cron, "5 10 * * *"}, {Ret.Hub, :vacuum_entry_codes, []}},
    {{:cron, "6 10 * * *"}, {Ret.Hub, :vacuum_hosts, []}},
    {{:cron, "7 10 * * *"}, {Ret.CachedFile, :vacuum, []}}
  ]

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

config :ret, Ret.Speelycaptor,
  speelycaptor_endpoint: "https://1dhaogh2hd.execute-api.us-west-1.amazonaws.com/public"

asset_hosts =
  "https://localhost:4000 https://localhost:8080 " <>
    "https://#{host} https://#{host}:4000 https://#{host}:8080 https://#{host}:3000 https://#{host}:8989 https://#{host}:9090 https://#{cors_proxy_host}:4000 " <>
    "https://assets-prod.reticulum.io https://asset-bundles-dev.reticulum.io https://asset-bundles-prod.reticulum.io"

websocket_hosts =
  "https://localhost:4000 https://localhost:8080 wss://localhost:4000 " <>
    "https://#{host}:4000 https://#{host}:8080 wss://#{host}:4000 wss://#{host}:8080 wss://#{host}:8989 wss://#{host}:9090 " <>
    "wss://#{host}:4000 wss://#{host}:8080 https://#{host}:8080 https://localhost:8080 wss://localhost:8080"

config :ret, RetWeb.Plugs.AddCSP,
  script_src: asset_hosts,
  font_src: asset_hosts,
  style_src: asset_hosts,
  connect_src:
    "https://#{host}:8080 https://sentry.prod.mozaws.net #{asset_hosts} #{websocket_hosts} https://www.mozilla.org",
  img_src: asset_hosts,
  media_src: asset_hosts,
  manifest_src: asset_hosts

config :ret, Ret.OAuthToken, oauth_token_key: ""

config :ret, Ret.Guardian,
  issuer: "ret",
  # This config value is for local development only.
  secret_key: "47iqPEdWcfE7xRnyaxKDLt9OGEtkQG3SycHBEMOuT2qARmoESnhc76IgCUjaQIwX",
  ttl: {12, :weeks}

config :web_push_encryption, :vapid_details,
  subject: "mailto:admin@mozilla.com",
  public_key:
    "BAb03820kHYuqIvtP6QuCKZRshvv_zp5eDtqkuwCUAxASBZMQbFZXzv8kjYOuLGF16A3k8qYnIN10_4asB-Aw7w",
  # This config value is for local development only.
  private_key: "w76tXh1d3RBdVQ5eINevXRwW6Ow6uRcBa8tBDOXfmxM"

config :sentry,
  environment_name: :prod,
  json_library: Poison,
  included_environments: [:prod],
  tags: %{
    env: "prod"
  }

config :ret, Ret.Habitat, ip: "127.0.0.1", http_port: 9631

config :ret, Ret.RoomAssigner, balancer_weights: [{600, 1}, {300, 50}, {0, 500}]

config :ret, RetWeb.PageController,
  skip_cache: true,
  assets_path: "storage/assets",
  docs_path: "storage/docs"

config :ret, Ret.HttpUtils, insecure_ssl: true

config :ret, Ret.Meta, phx_host: host

config :ret, Ret.Repo.Migrations.AdminSchemaInit, postgrest_password: "password"
config :ret, Ret.StatsJob, node_stats_enabled: false, node_gauges_enabled: false
config :ret, Ret.Coturn, realm: "ret"
