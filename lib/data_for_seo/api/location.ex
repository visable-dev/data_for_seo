defmodule DataForSeo.API.SERP.Location do
  @moduledoc """
  Provides SERP Location API interfaces.
  """

  alias DataForSeo.Client

  @doc """
  Gets all locations by country for specific service: bing, google, youtube etc
  ## Examples
      DataForSeo.API.SERP.Locations.get_location_by_service_and_country("us")
  """
  @spec get_location_by_service_and_country(String.t(), String.t(), Keyword.t()) :: {:ok, map()} | {:error, term()}
  def get_location_by_service_and_country(service, country, opts \\ []) do
    Client.get("/v3/serp/#{service}/locations/#{country}")
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
