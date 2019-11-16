use Mix.Config

config :data_for_seo, :auth, [
  login: System.get_env("DATAFORSEO_LOGIN"),
  password: System.get_env("DATAFORSEO_PASSWORD")
]