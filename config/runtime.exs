import Config

config :ret, RetWeb.Plugs.PostgrestProxy,
  hostname: System.get_env("POSTGREST_INTERNAL_HOSTNAME", "localhost")

case config_env() do
  :dev ->
    db_hostname = System.get_env("DB_HOST", "localhost")
    dialog_hostname = System.get_env("DIALOG_HOSTNAME", "hubs.lookfoto.cc")
    hubs_admin_internal_hostname = System.get_env("HUBS_ADMIN_INTERNAL_HOSTNAME", "hubs.lookfoto.cc")
    hubs_client_internal_hostname = System.get_env("HUBS_CLIENT_INTERNAL_HOSTNAME", "hubs.lookfoto.cc")
    spoke_internal_hostname = System.get_env("SPOKE_INTERNAL_HOSTNAME", "hubs.lookfoto.cc")

    dialog_port =
      "DIALOG_PORT"
      |> System.get_env("4443")
      |> String.to_integer()

    perms_key =
      "PERMS_KEY"
      |> System.get_env("")
      |> String.replace("\\n", "\n")

    config :ret, Ret.JanusLoadStatus, default_janus_host: dialog_hostname, janus_port: dialog_port

    config :ret, Ret.Locking,
      session_lock_db: [
        database: "ret_dev",
        hostname: db_hostname,
        password: "postgres",
        username: "postgres"
      ]

    config :ret, Ret.PermsToken, perms_key:  "-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQCflBBAL5NKsXoEr6bcnMOdqoVaspg8Do2uDQJoNAEFLV8HWIz+\nYYQhSgsVDD5qowrN16aq0NA6v4f2bFqzpgPndyBhExYdF9zOnp6b7uR7ak2ipujJ\nACusQx7mU/PMAKAnfDDdyOhZuj0O2MUzyfbsAB19OtFuf3upLIRQo1jLRQIDAQAB\nAoGAeHsJaeyBgDtOrIsRqC6TYk6EMF32oiE6xtX7o0DgJFCFFr68dLKbV6bXhySf\nW1ONrKvModrV3AUPWfWk5U3KU5XwDEG/bweKqD9qnDdJIlPH+yv095Q+i3DzikFw\neZS8f22ZNyVxudsr74ekql18yhhCQmAKHJ6C/uQg1odl/wECQQD/lWwpomxZ+BVo\nNI8BOCps8vhyLyoHYXKH/YlvnCDjD5pSKWxY66CmO2m+ccZ/cTy4dRMhKW0vezgp\nF2l7bMCJAkEAn9abapzJf6IrMO+ZRg4ySz0zRVJqkLPgVIdVFbUHmKDhDUJmZKRG\ncU/b4qJOht+2CrVlvgk1DB+UnRwNuwqt3QJBAJURQZTG9wtCdrngbcf4SkZhMCbo\n+0pyu6o1ZgOCvGuynf9tyZPTWk+aN4KsOWn7Ub8ECbQ9xUD8TTUqQouKUoECQEOs\nFeL+fKVIIKc4Whl5+zs1rxZjfXDEZ28CWTi2i3/IZWA6w6VKk/R3ji4W785Uuvsv\nr+LUfRwj5sTZ0splDBUCQQCHMAfq/lhe2Ku62hVNDu7NRzxYHmZu61YHggnqZnZT\nWID2aVCHJxPLkXDGUvA3+Jh9JfPiczw4S7Rjd//URydX\n-----END RSA PRIVATE KEY-----"

    config :ret, Ret.PageOriginWarmer,
      admin_page_origin: "https://#{hubs_admin_internal_hostname}:8989",
      hubs_page_origin: "https://#{hubs_client_internal_hostname}:8080",
      spoke_page_origin: "https://#{spoke_internal_hostname}:9090"

    config :ret, Ret.Repo, hostname: db_hostname

    config :ret, Ret.SessionLockRepo, hostname: db_hostname

  :test ->
    db_credentials = System.get_env("DB_CREDENTIALS", "admin")
    db_hostname = System.get_env("DB_HOST", "localhost")

    config :ret, Ret.Repo,
      hostname: db_hostname,
      password: db_credentials,
      username: db_credentials

    config :ret, Ret.SessionLockRepo,
      hostname: db_hostname,
      password: db_credentials,
      username: db_credentials

    config :ret, Ret.Locking,
      session_lock_db: [
        database: "ret_test",
        hostname: db_hostname,
        password: db_credentials,
        username: db_credentials
      ]

  _ ->
    :ok
end
