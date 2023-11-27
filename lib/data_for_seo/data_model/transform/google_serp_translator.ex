defmodule DataForSeo.DataModel.Transform.GoogleSerpTranslator do
  use DataForSeo.DataModel.Translator

  alias DataForSeo.DataModel.SERP.Google.SerpResult
  alias DataForSeo.DataModel.SERP.TaskReadyItem

  @spec translate_organic_result(task_path(), input_result()) :: SerpResult.t()
  def translate_organic_result(path, result) do
    ["v3", "serp", "google", "organic" | path_tail] = path

    case path_tail do
      ["tasks_ready"] ->
        load_map_into(result, TaskReadyItem)

      ["task_post"] ->
        nil

      ["task_get", "regular", _id] ->
        load_map_into(result, SerpResult, :load_regular)
        # ["v3", "serp", "google", "organic" |  _] -> load_map_into(result, GoogleResult)
    end
  end
end
