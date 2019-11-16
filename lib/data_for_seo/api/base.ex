defmodule DataForSeo.API.Base do
  @moduledoc """
  Provides basic and common functionalities for DataForSeo API.
  """

  @doc """
  Send request to the api.dataforseo.com server.
  """
  def request(path, method, params \\ %{}) do
    IO.inspect({path, method, params})
    do_request(request_url(path), method, params)
  end

  def request_url(path) do
    "https://api.dataforseo.com/#{path}"
  end

  defp do_request(url, method, params, options \\ [parse_result: true]) do
    auth = DataForSeo.Config.get_tuples() |> verify_params

    IO.inspect({url, method, params})

    response = mojito_request(url, method, params, auth)

    IO.inspect(response)

    case response do
      {:ok, r} ->
        process_mojito_response(r, options)

      _ ->
        raise(DataForSeo.ConnectionError, reason: "unknown")
    end
  end

  def verify_params([]) do
    raise DataForSeo.Error,
      message:
        "Auth parameters are not set. Use DataForSeo.configure function to set parameters in advance."
  end

  def verify_params(params), do: params

  defp mojito_request(url, :get, params, auth) do
    url
    |> URI.parse()
    |> Map.put(:query, URI.encode_query(params))
    |> URI.to_string()
    |> Mojito.get([{"content-type", "application/json"}, auth_headers(auth)])
  end

  defp mojito_request(url, :post, params, auth) do
    Mojito.post(
      url,
      [{"content-type", "application/json"}, auth_headers(auth)],
      Jason.encode!(params)
    )
  end

  defp auth_headers(auth) do
    Mojito.Headers.auth_header(auth[:login], auth[:password])
  end

  defp process_mojito_response(%Mojito.Response{body: body} = _response, _options) do
    # TODO get parse_result from options and use it.
    parsed_body = Jason.decode!(body)

    case parsed_body do
      %{"error" => %{"code" => code, "message" => message}} ->
        raise(DataForSeo.Error, code: code, message: message)

      _ ->
        parsed_body
    end
  end
end
