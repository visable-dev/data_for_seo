defmodule DataForSeo.Serp.CreateTasksResponse do
  @moduledoc """
  PostTaskResponse object.
  ## Reference
  https://docs.dataforseo.com/v2/srp#setting-serp-tasks
  """

  alias DataForSeo.Serp.CreatedTask

  defstruct [:status, :error, :results_time, :results_count, :results]
  @type t :: %__MODULE__{}

  def build(data) do
    case data["status_code"] do
      20000 ->
        {:ok, build_response_for_tasks(data["tasks"])}

      _ ->
        {:error, {data["status_code"], data["status_message"]}}
    end
  end

  defp build_response_for_tasks(tasks) do
    Enum.map(tasks, &CreatedTask.build/1)
  end
end
