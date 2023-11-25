defmodule DataForSeo.API.Keywords.GoogleAds.Languages do
  @moduledoc """
  Provides API interfaces to Keyword Data API / Google Ads / Languages :
    https://docs.dataforseo.com/v3/keywords_data/google_ads/languages/
  """

  alias DataForSeo.Client

  @doc """
  Gets all languages for google ads
  ## Examples
      DataForSeo.API.Keywords.GoogleAds.Languages.get_all_languages()
  """
  @spec get_all_languages(Keyword.t()) :: {:ok, map()} | {:error, term()}
  def get_all_languages(opts \\ []) do
    Client.get("/v3/keywords_data/google_ads/languages")
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
