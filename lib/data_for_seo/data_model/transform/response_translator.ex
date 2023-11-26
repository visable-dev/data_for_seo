defmodule DataForSeo.DataModel.Transform.ResponseTranslator do
  use DataForSeo.DataModel.Translator
  alias DataForSeo.DataModel.Generic.Response
  alias DataForSeo.DataModel.Generic.Task
  alias Ecto.Changeset

  alias DataForSeo.DataModel.Transform.GoogleSerpTranslator
  alias DataForSeo.DataModel.Transform.LabsGoogleTranslator

  @spec load_response(map()) :: Response.t()
  def load_response(data) do
    :load
    |> Response.changeset(data)
    |> Changeset.apply_changes()
  end

  @spec get_tasks(Response.t()) :: [Task.t()]
  def get_tasks(%Response{tasks: tasks}), do: tasks

  @doc """
  Get result representation for specific task. It could a struct. If no struct defined it returns maps.
  Splitting Result/Task and it's internal representation helps to avoid complicated logic with polymorph types
  and use Ecto as an engine.
    It returns result representation
  """
  @spec translate_task_result(Task.t()) :: struct() | map() | [struct()] | [map()]
  def translate_task_result(%Task{path: path, result: result}) do
    case path do
      ["v3", "serp", "google", "organic" | _] ->
        GoogleSerpTranslator.translate_organic_result(path, result)

      ["v3", "dataforseo_labs", "google" | _] ->
        LabsGoogleTranslator.translate_google_result(path, result)
    end
  end

  @doc """
  It's a wrapper to `translate_task_result/1` that put translated result back to the task internal field.
  """
  @spec load_task_result(Task.t()) :: Task.t()
  def load_task_result(task = %Task{}) do
    translated_result = translate_task_result(task)
    Map.put(task, :result, translated_result)
  end
end
