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
    |> convert_date_time("datetime")
    |> Spect.to_spec!(GetTaskResponse)
  end

  def parse(body, :raw_task_result) do
    body
    |> convert_date_time("datetime")
  end

  def parse(body, :tasks_ready) do
    body
    |> convert_date_time("date_posted")
    |> Spect.to_spec!(BaseResponse)
  end

  def parse(resp, _) do
    resp
  end

  def convert_date_time(body, field_name) do
    case get_in(body, ["tasks", Access.all(), "result"]) do
      [nil] ->
        body

      _ ->
        body
        |> update_in(
          ["tasks", Access.all(), "result", Access.all(), field_name],
          &String.replace_suffix(&1, " +00:00", "Z")
        )
    end
  end
end
