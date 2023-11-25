defmodule DataForSeo.Client do
  @moduledoc """
  Provides basic and common functionalities for DataForSeo API based on Finch.
  """

  alias DataForSeo.Config

  def get(path, query_params \\ []) do
    url = request_url(path)

    get_request(url, query_params, headers())
  end

  def post(path, query_params \\ []) do
    url = request_url(path)
    # params = Jason.encode!(query_params)

    # |> Mojito.post(headers(), Jason.encode!(params))

    post_request(url, [], query_params, headers())
  end

  @doc """
  Generates basic Auth header from the given username and password

  ## Example

    iex> DataForSeo.Client.basic_auth_header("user", "hello")
    {"Authorization", "Basic dXNlcjpoZWxsbw=="}

  """
  def basic_auth_header(username, password) do
    auth64 = "#{username}:#{password}" |> Base.encode64()
    {"Authorization", "Basic #{auth64}"}
  end

  def get_request(url, query_params \\ [], headers \\ [], body \\ nil, opts \\ []) do
    :get
    |> build_request(url, query_params, headers, body)
    |> execute_request(opts)
  end

  def post_request(url, query_params \\ [], body \\ %{}, headers \\ [], opts \\ []) do
    body = Jason.encode!(body)

    :post
    |> build_request(url, query_params, headers, body)
    |> execute_request(opts)
  end

  def put_request(url, query_params \\ [], body \\ %{}, headers \\ [], opts \\ []) do
    body = Jason.encode!(body)

    :put
    |> build_request(url, query_params, headers, body)
    |> execute_request(opts)
  end

  def patch_request(url, query_params \\ [], body \\ %{}, headers \\ [], opts \\ []) do
    body = Jason.encode!(body)

    :patch
    |> build_request(url, query_params, headers, body)
    |> execute_request(opts)
  end

  def delete_request(url, query_params \\ [], headers \\ [], opts \\ []) do
    :delete
    |> build_request(url, query_params, headers, nil)
    |> execute_request(opts)
  end

  def validate_status_code(_ok_error, _ok_statuses \\ [200])

  def validate_status_code({:ok, response} = ok, ok_statuses) do
    if Enum.member?(ok_statuses, response.status) do
      ok
    else
      {:error, response}
    end
  end

  def validate_status_code({:error, _message} = error, _ok_statuses) do
    error
  end

  def decode_json_response(_response, _opts \\ [])

  def decode_json_response({:ok, %{body: body}}, opts) do
    case Jason.decode(body, opts) do
      {:ok, parsed_body} ->
        {:ok, parsed_body}

      {:error, %Jason.DecodeError{data: data}} ->
        {:error, data}
    end
  end

  def decode_json_response({:error, _message} = error, _opts) do
    error
  end

  # Helpers

  defp headers do
    config = Config.get_tuples() |> verify_config()

    [basic_auth_header(config[:login], config[:password]), {"content-type", "application/json"}]
  end

  defp request_url(path) do
    config = Config.get_tuples() |> verify_config()

    config[:base_url] <> path
  end

  defp verify_config([]) do
    raise DataForSeo.Error,
      message:
        "Config parameters are not set. Use DataForSeo.configure function to set parameters in advance."
  end

  defp verify_config(params), do: params

  defp build_request(method, url, query_params, headers, body) do
    url =
      url
      |> URI.parse()
      |> Map.put(:query, URI.encode_query(query_params))
      |> URI.to_string()

    Finch.build(method, url, headers, body)
  end

  defp execute_request(request, opts) do
    timeouts = timeout_options(opts)
    config = Config.get_tuples() |> verify_config()
    finch_name = opts[:finch_name] || config[:finch_name] || ApiFinch
    Finch.request(request, finch_name, timeouts)
  end

  defp timeout_options(opts) do
    config = Config.get_tuples() |> verify_config()

    [:receive_timeout, :pool_timeout]
    |> Enum.reduce(opts, fn key, acc ->
      case opts[key] || config[key] do
        nil -> acc
        value -> Keyword.put(acc, key, to_integer(value))
      end
    end)
  end

  defp to_integer(value) when is_binary(value), do: String.to_integer(value)
  defp to_integer(value), do: value
end
