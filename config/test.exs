use Mix.Config

config :data_for_seo, :api,
  base_url: "http://localhost",
  login: System.get_env("DATAFORSEO_LOGIN"),
  password: System.get_env("DATAFORSEO_PASSWORD"),
  default_language_code: "en",
  default_location_name: "San Francisco,California,United States",
  default_se_domain: "google.com"
