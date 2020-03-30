defmodule DataForSeo.Request do
  @moduledoc """
  Provides basic and common functionalities for DataForSeo API.
  """

  alias DataForSeo.Config

  def get(path) do
    request_url(path)
    |> Mojito.get(headers())
  end

  def get(path, params) do
    request_url(path)
    |> URI.parse()
    |> Map.put(:query, URI.encode_query(params))
    |> URI.to_string()
    |> Mojito.get(headers())
  end

  def post(path, params) do
    request_url(path)
    |> Mojito.post(headers(), Jason.encode!(params))
  end

  defp headers do
    [auth_headers(), {"content-type", "application/json"}]
  end

  defp auth_headers() do
    config = Config.get_tuples() |> verify_config()

    Mojito.Headers.auth_header(config[:login], config[:password])
  end

  def request_url(path) do
    config = Config.get_tuples() |> verify_config()

    config[:base_url] <> path
  end

  defp verify_config([]) do
    raise DataForSeo.Error,
      message:
        "Config parameters are not set. Use DataForSeo.configure function to set parameters in advance."
  end

  defp verify_config(params), do: params
end
