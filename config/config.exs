import Config

config :data_for_seo, :api,
  base_url: "https://api.dataforseo.com",
  login: System.get_env("DATAFORSEO_LOGIN"),
  password: System.get_env("DATAFORSEO_PASSWORD"),
  pool_timeout: System.get_env("POOL_TIMEOUT"),
  receive_timeout: System.get_env("RECEIVE_TIMEOUT")

import_config "#{Mix.env()}.exs"
