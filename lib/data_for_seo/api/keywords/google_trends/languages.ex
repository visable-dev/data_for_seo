defmodule DataForSeo.API.Keywords.GoogleTrends.Languages do
  @moduledoc """
  Provides API interfaces to Keyword Data API / Google Trends / Languages :
    https://docs.dataforseo.com/v3/keywords_data/google_trends/languages/
  """

  alias DataForSeo.Client

  @doc """
  Gets all languages for google trends
  ## Examples
      DataForSeo.API.Keywords.GoogleTrends.Languages.get_all_languages()
  """
  @spec get_all_languages(Keyword.t()) :: {:ok, map()} | {:error, term()}
  def get_all_languages(opts \\ []) do
    Client.get("/v3/keywords_data/google_trends/languages")
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
