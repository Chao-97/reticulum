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
        password: "Pp232400!!",
        username: "postgres"
      ]

    # config :ret, Ret.PermsToken, perms_key: "-----BEGIN RSA PRIVATE KEY-----\nMIICWwIBAAKBgQCtzZwdkJCD95+YAsyB49X5YFTocikPRAQvSuAsaUixMHJsSDW9\nr/Xfd0h8g/WQyRRkTjbbIVwzULfCU2awjNjPK9+9iHewQzqTwJiWLTTUl8JAdVXk\nbDuDU21XYc9j+3bcxxZKfmwJjXBzkXc0AO6q0XJT+pwMaqV7+lzDEdfaLQIDAQAB\nAoGAGV0UF0xtipSseaaO6bWyGD5ypaljTJMEeVJX/KMwtIr5Z8vx68it/PqPXXx0\nbbiqfSjc4IWxyttQtc8uAT3MtdBvBiAN6GempHiupdCZ7CSSG4e3D4Yvkip0QCOd\nqiSiAGbnq97u2Sc85PDpKPjqfX+TKil6dw9HT+gYDeHzbpECQQD+ZvqsVti+/1jY\n9XBmgctnpNPABXnayxsjPJA78gsEoV1fptKWwrBkrFjxqduBUpbUeOoYwEa6mF16\nOU5a85UHAkEAruULsN8yYCzFylL+ZSrTRBOSWPO3MhDJI0cV9CMAduI2Cb+x+SXd\nwshGXeYilm35YUeG4WnWV/pMBTmsVhEeKwJAcRPA1B1+FddV3ImrvkRu7tCatj04\n3oFsvIrM6Xg6YYKACGYUMKK02OqqVjBTuvXEyQg9tWaxiXr0AcG7DD48vQJARQ5x\nWEw44tqq2mF8y0tmkcm8jlzk5+LS2JgX5gbwBwD4306Oola+Qku75RWacJVJ04xf\niJ+2n5RX8fQ8xNsLcwJAXI6FVu+1ihttzNaXl9UYQiQOHmvtbb/xqYUCaIVmw/Yi\nXcSi3pENA6dka5C4hQlE8M6eArfxBvagRzGlrdqsGQ==\n-----END RSA PRIVATE KEY-----"
    config :ret, Ret.PermsToken, perms_key: "-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQCt+VJDI3yfGUChntSDVBSeK8lFoWVtzBIQykfsx5zl/yVK8LkL\nftmUEq2436XHMoUXLfycZkGZnIlr9WdFDvfowOTCSu1KrfHkgdHQuHoo/nt13FfL\ngb5VJmNxX85v5Hl+Nc/g55To1HKPkwVnDdqZ3dOWI7w5UiAkLUrfFAuu/QIDAQAB\nAoGAL2nknoGcZCvYrnOADW6r09OxHfX3k63rOoI2ifR48UHRIxRqChT/LVjN2bWy\nE5DULtYMo39G35uG5FJUW8DRlTv8czubdMWpVmXeb9QwRQEzePZOdDcl+9Pr3xKd\n0tNLtusQ3NkXpWfi/Bn1r7+P3KcQG0/iRteguSaWdrUuS6ECQQD3/yzGXUfCFs+V\nlx9G3yVf8CBsjb8VAMoNgN3yz1I5De+pPWMNqEuMWfRobwcnxpOuO5L5a8Gd1D3U\nMf6oI9RpAkEAs5abSwyPFMKkrch+Lir0690LFKtEr+bLNat689eM/ddHpbrIWrZx\ndVM+ANa0cepl+Uo1Pp2YzOI2To2+L29jdQJAKf7iPC0rq6hlOrW+rCe5kod9ViSi\nyRG7JZI/A5EsIVFE1mn4ziVDtd69zrmOgqPT+ltIRkiDHxED710P/LUkkQJANNzB\nK28v8sF0rf7VPYvBemgfad8cIdcCu/KVB4/MXa/v1BXOAf2wGgP9vUt15A5GJAI2\n+A51uuFfcPICKH5WPQJBAJ1ZuK956dIpCb3SMTNYfLX600FWtsxaseu/Q6cxt+UN\nvpNwhHVPR06zaZHErq4FiWk2QlwnAc03yccRYSjT0E4=\n-----END RSA PRIVATE KEY-----"

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
