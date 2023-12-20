defmodule DataForSeo.API.Keywords.GoogleAds.Locations do
  @moduledoc """
  Provides API interfaces to Keyword Data API / Google Ads / Locations :
    https://docs.dataforseo.com/v3/keywords_data/google_ads/locations/
  """

  alias DataForSeo.Client

  @doc """
  Gets all locations for Google Ads
  ## Examples
      DataForSeo.API.Keywords.GoogleAds.Locations.get_all_locations()
  """
  @spec get_all_locations(Keyword.t()) :: {:ok, map()} | {:error, term()}
  def get_all_locations(opts \\ []) do
    Client.get("/v3/keywords_data/google_ads/locations")
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
