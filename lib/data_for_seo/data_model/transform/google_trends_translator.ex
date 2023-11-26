defmodule DataForSeo.DataModel.Transform.GoogleTrendsTranslator do
  use DataForSeo.DataModel.Translator

  alias DataForSeo.DataModel.Keywords.GoogleTrends.ExplorerResult
  alias DataForSeo.DataModel.Keywords.GoogleTrends.Explorer.TaskReadyItem

  @spec translate_organic_result(task_path(), input_result()) :: SerpResult.t()
  def translate_organic_result(["v3", "keywords_data", "google_trends" | path_tail], result) do
    case path_tail do
      ["explore", "tasks_ready"] ->
        load_map_into(result, TaskReadyItem)

      ["explore", "task_post"] ->
        nil

      ["explore", "task_get", "regular", _id] ->
        load_map_into(result, SerpResult, :load_regular)
        # ["v3", "serp", "google", "organic" |  _] -> load_map_into(result, GoogleResult)
    end
  end
end
