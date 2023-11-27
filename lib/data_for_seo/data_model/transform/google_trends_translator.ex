defmodule DataForSeo.DataModel.Transform.GoogleTrendsTranslator do
  use DataForSeo.DataModel.Translator

  alias DataForSeo.DataModel.Keywords.GoogleTrends.ExplorerResult
  alias DataForSeo.DataModel.Keywords.GoogleTrends.Explorer.TaskReadyItem
  #  alias DataForSeo.DataModel.Keywords.GoogleTrends.ExplorerItem

  @spec translate_trends_result(task_path(), input_result()) :: SerpResult.t()
  def translate_trends_result(["v3", "keywords_data", "google_trends" | path_tail], result) do
    case path_tail do
      ["explore", "tasks_ready"] ->
        load_map_into(result, TaskReadyItem)

      ["explore", "task_post"] ->
        nil

      ["explore", "task_get", _id] ->
        load_map_into(result, ExplorerResult)

      ["explore", "live"] ->
        load_map_into(result, ExplorerResult)
    end
  end

  # workaround, for some reasons API shows path different from another google trends paths
  def translate_trends_result(["v3", "keywords_data", "google", "explore", "tasks_ready"], result) do
    load_map_into(result, TaskReadyItem)
  end
end
