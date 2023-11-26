defmodule DataForSeo.DataModel.Transform.LabsGoogleTranslator do
  use DataForSeo.DataModel.Translator

  alias DataForSeo.DataModel.Labs.Google.SearchIntentResult
  alias DataForSeo.DataModel.Labs.Google.KeywordsForSiteResult
  alias DataForSeo.DataModel.Labs.Google.KeywordsIdeasResult
  alias DataForSeo.DataModel.Labs.Google.KeywordsSuggestionsResult
  alias DataForSeo.DataModel.Labs.Google.RelatedKeywordsResult
  alias DataForSeo.DataModel.Labs.Google.BulkKeywordDifficultyResult

  @spec translate_google_result(task_path(), input_result()) :: SerpResult.t()
  def translate_google_result(path, result) do
    ["v3", "dataforseo_labs", "google" | path_tail] = path

    case path_tail do
      ["search_intent", "live"] -> load_map_into(result, SearchIntentResult)
      ["keywords_for_site", "live"] -> load_map_into(result, KeywordsForSiteResult)
      ["keyword_ideas", "live"] -> load_map_into(result, KeywordsIdeasResult)
      ["keyword_suggestions", "live"] -> load_map_into(result, KeywordsSuggestionsResult)
      ["related_keywords", "live"] -> load_map_into(result, RelatedKeywordsResult)
      ["bulk_keyword_difficulty", "live"] -> load_map_into(result, BulkKeywordDifficultyResult)

    end
  end
end
