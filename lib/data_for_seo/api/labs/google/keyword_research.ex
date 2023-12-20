defmodule DataForSeo.API.Labs.Google.KeywordResearch do
  @moduledoc """
  Access to Labs / Google / KeywordResearch API endpoints
  """
  use DataForSeo.API.EndpointHandler

  @endpoints %{
    search_intent: "/v3/dataforseo_labs/google/search_intent/live",
    keywords_for_site: "/v3/dataforseo_labs/google/keywords_for_site/live",
    related_keywords: "/v3/dataforseo_labs/google/related_keywords/live",
    keyword_ideas: "/v3/dataforseo_labs/google/keyword_ideas/live",
    keyword_suggestions: "/v3/dataforseo_labs/google/keyword_suggestions/live"
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
      |> List.wrap()

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
  @spec keywords_for_site(
          String.t(),
          String.t() | non_neg_integer(),
          String.t(),
          map(),
          Keyword.t()
        ) ::
          {:ok, map()} | {:error, term()}
  def keywords_for_site(target, loc_name_or_code, lang_name_or_code, optional_payload, opts \\ []) do
    payload =
      %{target: target}
      |> apply_location(loc_name_or_code)
      |> apply_language(lang_name_or_code)
      |> Map.merge(optional_payload)
      |> List.wrap()

    @endpoints
    |> Map.get(:keywords_for_site)
    |> Client.post(payload)
    |> Client.validate_status_code()
    |> Client.decode_json_response(opts)
    |> handle_response()
  end

  @doc """
  The Related Keywords endpoint provides keywords appearing in the  "searches related to" SERP element
  You can get up to 4680 keyword ideas by specifying the search depth.
  Each related keyword comes with the list of relevant product categories, search volume rate for the last month,
  search volume trend for the previous 12 months, as well as current cost-per-click and competition values.
  Moreover, this endpoint supplies minimum, maximum and average values of daily impressions,
  clicks and CPC for each result.
  Read more: https://docs.dataforseo.com/v3/dataforseo_labs/google/related_keywords/live/

  ## Examples
  DataForSeo.API.Labs.Google.KeywordResearch.related_keywords("apples", 2840, "en", %{}, nil)

  DataForSeo.API.Labs.Google.KeywordResearch.related_keywords("apples", "Uruguay", "English", %{})
  """
  @spec related_keywords(
          String.t(),
          String.t() | non_neg_integer(),
          String.t(),
          map(),
          Keyword.t()
        ) ::
          {:ok, map()} | {:error, term()}
  def related_keywords(keyword, loc_name_or_code, lang_name_or_code, optional_payload, opts \\ []) do
    payload =
      %{keyword: keyword}
      |> apply_location(loc_name_or_code)
      |> apply_language(lang_name_or_code)
      |> Map.merge(optional_payload)
      |> List.wrap()

    @endpoints
    |> Map.get(:related_keywords)
    |> Client.post(payload)
    |> Client.validate_status_code()
    |> Client.decode_json_response(opts)
    |> handle_response()
  end

  @doc """
  The Keyword Ideas endpoint provides search terms that are relevant to the product or service categories of the
  specified keywords.
  The algorithm selects the keywords which fall into the same categories as the seed keywords
  specified in a POST array.


  Read more: https://docs.dataforseo.com/v3/dataforseo_labs/google/keyword_ideas/live/

  ## Examples
  DataForSeo.API.Labs.Google.KeywordResearch.keyword_ideas("apples", 2840, "en", %{}, nil)

  DataForSeo.API.Labs.Google.KeywordResearch.keyword_ideas("apples", "Uruguay", "English", %{})
  """
  @spec keyword_ideas(
          [String.t()],
          String.t() | non_neg_integer(),
          String.t(),
          map(),
          Keyword.t()
        ) ::
          {:ok, map()} | {:error, term()}
  def keyword_ideas(keywords, loc_name_or_code, lang_name_or_code, optional_payload, opts \\ []) do
    payload =
      %{keywords: keywords}
      |> apply_location(loc_name_or_code)
      |> apply_language(lang_name_or_code)
      |> Map.merge(optional_payload)
      |> List.wrap()

    @endpoints
    |> Map.get(:keyword_ideas)
    |> Client.post(payload)
    |> Client.validate_status_code()
    |> Client.decode_json_response(opts)
    |> handle_response()
  end

  @doc """
  ### Keyword Suggestions
  The Keyword Suggestions endpoint provides search queries that include the specified seed keyword.
  The algorithm is based on the full-text search for the specified keyword and therefore returns
  only those search terms that contain the keyword you set in the POST array with additional words before, after,
  or within the specified key phrase. Returned keyword suggestions can contain the words from the specified key
  phrase in a sequence different from the one you specify.
  As a result, you will get a list of long-tail keywords with each keyword in the
  list matching the specified search term.


  Read more: https://docs.dataforseo.com/v3/dataforseo_labs/google/keyword_suggestions/live/

  ## Examples
  DataForSeo.API.Labs.Google.KeywordResearch.keyword_suggestions("apples", 2840, "en", %{}, nil)

  DataForSeo.API.Labs.Google.KeywordResearch.keyword_suggestions("apples", "Uruguay", "English", %{})
  """
  @spec keyword_suggestions(
          String.t(),
          String.t() | non_neg_integer(),
          String.t(),
          map(),
          Keyword.t()
        ) ::
          {:ok, map()} | {:error, term()}
  def keyword_suggestions(
        keyword,
        loc_name_or_code,
        lang_name_or_code,
        optional_payload,
        opts \\ []
      ) do
    payload =
      %{keyword: keyword}
      |> apply_location(loc_name_or_code)
      |> apply_language(lang_name_or_code)
      |> Map.merge(optional_payload)
      |> List.wrap()

    @endpoints
    |> Map.get(:keyword_suggestions)
    |> Client.post(payload)
    |> Client.validate_status_code()
    |> Client.decode_json_response(opts)
    |> handle_response()
  end
end
