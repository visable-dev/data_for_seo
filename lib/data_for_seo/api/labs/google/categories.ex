defmodule DataForSeo.API.Labs.Google.Categories do
  @moduledoc """
  Provides API interfaces to Labs / Google / Categories API:
    https://docs.dataforseo.com/v3/dataforseo_labs/categories_list/
  """

  alias DataForSeo.Client

  @doc """
  Gets all locations by country for specific service: bing, google, youtube etc
  ## Examples
      DataForSeo.API.Labs.Google.Categories.get_all_categories()
  """
  @spec get_all_categories(Keyword.t()) :: {:ok, map()} | {:error, term()}
  def get_all_categories(opts \\ []) do
    Client.get("/v3/dataforseo_labs/categories")
    |> Client.validate_status_code()
    |> Client.decode_json_response(opts)
    |> case do
      {:ok, resp} ->
        {:ok, resp}

      {:error, error} ->
        {:error, error}
    end
  end
end
