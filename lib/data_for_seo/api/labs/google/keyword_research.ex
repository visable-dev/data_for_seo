defmodule DataForSeo.API.Labs.Google.KeywordResearch do
  @moduledoc """
  Access to Labs / Google / KeywordResearch API endpoints
  """

  alias DataForSeo.Client

  @endpoints %{
    search_intent: "/v3/dataforseo_labs/google/search_intent/live",
    keywords_for_site: "/v3/dataforseo_labs/google/keywords_for_site/live"
  }

  @doc """
  This endpoint will provide you with search intent data for up to 1,000 keywords. For each keyword that you specify
  when setting a task, the API will return the keyword’s search intent and intent probability.
  Besides the highest probable search intent, the results will also provide you with other likely search intent(s)
  and their probability.

  Based on keyword data and search results data, our system has been trained to detect four types of search intent:
  informational, navigational, commercial, transactional.
  Read more: https://docs.dataforseo.com/v3/dataforseo_labs/google/search_intent/live/

  ## Examples
  DataForSeo.API.Labs.Google.KeywordResearch.search_intent(["audi a7", "milk store new york"], "en", nil)

  DataForSeo.API.Labs.Google.KeywordResearch.search_intent(["audi a7", "milk store new york"], "English", "uniq-tag")
  """
  @spec search_intent([String.t()], String.t(), String.t() | nil, Keyword.t()) ::
          {:ok, map()} | {:error, term()}
  def search_intent(keywords, lang_name_or_code, tag, opts \\ []) do
    payload =
      %{keywords: keywords}
      |> apply_language(lang_name_or_code)
      |> apply_tag(tag)

    @endpoints
    |> Map.get(:search_intent)
    |> Client.post(payload)
    |> Client.validate_status_code()
    |> Client.decode_json_response(opts)
    |> handle_response()
  end

  @doc """
  The Keywords For Site endpoint will provide you with a list of keywords relevant to the target domain.
  Each keyword is supplied with relevant categories, search volume data for the last month, cost-per-click,
  competition, and search volume trend values for the past 12 months.
  Read more: https://docs.dataforseo.com/v3/dataforseo_labs/google/keywords_for_site/live/

  ## Examples
  DataForSeo.API.Labs.Google.KeywordResearch.keywords_for_site("apple.com", 2840, "en", %{}, nil)

  DataForSeo.API.Labs.Google.KeywordResearch.keywords_for_site("apple.com", "Uruguay", "English", %{})
  """
  @spec keywords_for_site(String.t(), String.t() | non_neg_integer(), String.t(), map(), Keyword.t()) ::
          {:ok, map()} | {:error, term()}
  def keywords_for_site(target, loc_name_or_code, lang_name_or_code, optional_payload, opts \\ []) do
    payload =
      %{target: target}
      |> apply_location(loc_name_or_code)
      |> apply_language(lang_name_or_code)
      |> Map.merge(optional_payload)

    @endpoints
    |> Map.get(:keywords_for_site)
    |> Client.post(payload)
    |> Client.validate_status_code()
    |> Client.decode_json_response(opts)
    |> handle_response()
  end

  defp handle_response(resp), do: resp

  defp apply_location(attrs, loc) do
    # test location, if it's integer - we have location code
    # we support code both: as int and string
    case Integer.parse("#{loc}") do
      :error -> Map.put(attrs, :location_name, loc)
      {code, _} -> Map.put(attrs, :location_code, code)
    end

  end


  defp apply_language(attrs, <<code::binary-size(2), "">>), do:  Map.put(attrs, :language_code, code)
  defp apply_language(attrs, lang_name), do: Map.put(attrs, :language_name, lang_name)

  defp apply_tag(attrs, nil), do: attrs
  defp apply_tag(attrs, tag = <<_::binary-size(1), _::binary>>), do: Map.put(attrs, :tag, tag)
end
