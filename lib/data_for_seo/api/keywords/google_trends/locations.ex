defmodule DataForSeo.API.Keywords.GoogleTrends.Locations do
  @moduledoc """
  Provides API interfaces to Keyword Data API / Google Trends / Locations :
    https://docs.dataforseo.com/v3/keywords_data/google_trends/locations/
  """

  alias DataForSeo.Client

  @doc """
  Gets all locations for google trends
  ## Examples
      DataForSeo.API.Keywords.GoogleTrends.Locations.get_all_locations()
  """
  @spec get_all_locations(Keyword.t()) :: {:ok, map()} | {:error, term()}
  def get_all_locations(opts \\ []) do
    Client.get("/v3/keywords_data/google_trends/locations")
    |> Client.validate_status_code()
    |> Client.decode_json_response(opts)
    |> case do
      {:ok, resp} ->
        {:ok, resp}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Gets all locations for google trends
  ## Examples
      DataForSeo.API.Keywords.GoogleTrends.Locations.get_all_locations_by_country("ua")
  """
  @spec get_all_locations_by_country(String.t(), Keyword.t()) :: {:ok, map()} | {:error, term()}
  def get_all_locations_by_country(country_code, opts \\ []) do
    Client.get("/v3/keywords_data/google_trends/locations/#{country_code}")
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
