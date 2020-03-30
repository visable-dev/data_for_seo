defmodule DataForSeo.Parser do
  @moduledoc """
  A parser built on top of Spect for decoding DataForSEO's various return
  structures.

  https://github.com/pylon/spect
  """

  alias DataForSeo.Serp.Response, as: BaseResponse
  alias DataForSeo.Serp.GetTask.Response, as: GetTaskResponse

  def parse(%Mojito.Response{body: body, status_code: code}, strategy) do
    case code do
      _ ->
        body = Jason.decode!(body)
        parse(body, strategy)
    end
  end

  def parse(body, :task_post) do
    body
    |> Spect.to_spec!(BaseResponse)
  end

  def parse(body, :task_result) do
    body
    |> convert_values(:task_result)
    |> Spect.to_spec!(GetTaskResponse)
  end

  def parse(body, :tasks_ready) do
    body
    |> convert_values(:tasks_ready)
    |> Spect.to_spec!(BaseResponse)
  end

  def parse(resp, _) do
    resp
  end

  defp convert_values(body, :tasks_ready) do
    body
    |> update_in(["tasks"], fn tasks ->
      tasks
      |> Enum.map(fn %{"result" => result} = task ->
        result =
          result
          |> Enum.map(fn result_item ->
            result_item
            |> update_in(["date_posted"], &String.replace_suffix(&1, " +00:00", "Z"))
          end)

        Map.put(task, "result", result)
      end)
    end)
  end

  defp convert_values(body, :task_result) do
    body
    |> update_in(["tasks"], fn tasks ->
      tasks
      |> Enum.map(fn %{"result" => result} = task ->
        result =
          result
          |> Enum.map(fn result_item ->
            result_item
            |> update_in(["datetime"], &String.replace_suffix(&1, " +00:00", "Z"))
          end)

        Map.put(task, "result", result)
      end)
    end)
  end
end
