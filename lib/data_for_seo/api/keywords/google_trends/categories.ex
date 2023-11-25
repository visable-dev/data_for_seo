defmodule DataForSeo.API.Keywords.GoogleTrends.Categories do
  @moduledoc """
  Provides API interfaces to Keyword Data API / Google Trends / Categories :
    https://docs.dataforseo.com/v3/keywords_data/google_trends/categories/
  """

  alias DataForSeo.Client

  @doc """
  Gets all categories for Google Trends
  ## Examples
      DataForSeo.API.Keywords.GoogleTrends.Categories.get_all_categories()
  """
  @spec get_all_categories(Keyword.t()) :: {:ok, map()} | {:error, term()}
  def get_all_categories(opts \\ []) do
    Client.get("/v3/keywords_data/google_trends/categories")
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
