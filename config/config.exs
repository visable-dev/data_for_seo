use Mix.Config

config :data_for_seo, :api,
  base_url: "https://api.dataforseo.com",
  login: System.get_env("DATAFORSEO_LOGIN"),
  password: System.get_env("DATAFORSEO_PASSWORD")

import_config "#{Mix.env()}*.exs"
