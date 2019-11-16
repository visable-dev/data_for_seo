defmodule DataForSeo.Serp.CompletedTasksResponse do
  @moduledoc """
  CompletedTasksResponse object.
  ## Reference
  https://docs.dataforseo.com/v2/srp#setting-serp-tasks
  """

  alias DataForSeo.Serp.CompletedTask

  defstruct [:status, :error, :results_time, :results_count, :results]
  @type t :: %__MODULE__{}

  def build(map_with_string_keys) do
    map_with_atom_keys =
      Map.new(map_with_string_keys, fn {key, value} ->
        case key do
          "results" ->
            {String.to_atom(key), build_completed_tasks(value)}

          _ ->
            {String.to_atom(key), value}
        end
      end)

    struct(__MODULE__, map_with_atom_keys)
  end

  defp build_completed_tasks(tasks_map) do
    tasks_map
    |> Enum.map(&CompletedTask.build/1)
  end
end
