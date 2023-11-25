defmodule DataForSeo.API.Labs.Google.KeywordResearch do
  @moduledoc """
  Access to Labs / Google / KeywordResearch API endpoints
  """

  alias DataForSeo.Client

  @endpoints %{
    search_intent: "/v3/dataforseo_labs/google/search_intent/live"
  }

  @doc """
  This endpoint will provide you with search intent data for up to 1,000 keywords. For each keyword that you specify
  when setting a task, the API will return the keyword’s search intent and intent probability.
  Besides the highest probable search intent, the results will also provide you with other likely search intent(s)
  and their probability.

  Based on keyword data and search results data, our system has been trained to detect four types of search intent:
  informational, navigational, commercial, transactional.

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

  defp handle_response(resp), do: resp

  defp apply_language(attrs, <<code::binary-size(2), "">>) do
    Map.put(attrs, :language_code, code)
  end

  defp apply_language(attrs, lang_name) do
    Map.put(attrs, :language_name, lang_name)
  end

  defp apply_tag(attrs, nil), do: attrs
  defp apply_tag(attrs, tag = <<_::binary-size(1), _::binary>>), do: Map.put(attrs, :tag, tag)
end
