defmodule DataForSeo.Serp.CreateTasksResponse do
  @moduledoc """
  PostTaskResponse object.
  ## Reference
  https://docs.dataforseo.com/v2/srp#setting-serp-tasks
  """

  alias DataForSeo.Serp.CreatedTask

  defstruct [:status, :error, :results_time, :results_count, :results]
  @type t :: %__MODULE__{}

  def build(map_with_string_keys) do
    map_with_atom_keys =
      Map.new(map_with_string_keys, fn {key, value} ->
        case key do
          "results" ->
            {String.to_atom(key), build_tasks(value)}

          _ ->
            {String.to_atom(key), value}
        end
      end)

    struct(__MODULE__, map_with_atom_keys)
  end

  defp build_tasks(tasks_map) do
    tasks_map
    |> Enum.map(fn {key, task_map} ->
      {key, CreatedTask.build(task_map)}
    end)
    |> Enum.into(%{})
  end
end
