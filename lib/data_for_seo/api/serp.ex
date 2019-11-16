defmodule DataForSeo.API.Serp do
  @moduledoc """
  Provides SERP API interfaces.
  """

  import DataForSeo.API.Base
  alias DataForSeo.Serp.{CreateTasksResponse, CompletedTasksResponse}

  @doc """
  Creates a task for each key.
  ## Options
    The `keys_with_unique_ids` is a map with the key => unique_id. You will need unique_id later
    to find your result in the completed tasks.
    * `:global` - configuration is shared for all processes.
    * `:process` - configuration is isolated for each process.
  ## Examples
      DataForSeo.API.Serp.create_tasks(%{"Schrauben" => 123987}, "German", "20537,Hamburg,Germany", "google.de")
  """
  def create_tasks(
        keys_with_unique_ids,
        se_language,
        loc_name_canonical,
        se_name,
        optional_params \\ %{}
      )
      when is_map(keys_with_unique_ids) do
    all_params =
      Enum.reduce(keys_with_unique_ids, %{}, fn {key, unique_id}, acc ->
        task_params =
          Map.merge(
            optional_params,
            %{
              key: key,
              se_language: se_language,
              loc_name_canonical: loc_name_canonical,
              se_name: se_name
            }
          )

        Map.put(acc, unique_id, task_params)
      end)

    "v2/srp_tasks_post"
    |> request(:post, %{data: all_params})
    |> CreateTasksResponse.build()
  end

  @doc """
  Gets completed tasks. All returned tasks are then removed from completed list. So be sure to save and process them.
  ## Examples
      DataForSeo.API.Serp.completed_tasks()
  """
  def completed_tasks do
    "v2/srp_tasks_get"
    |> request(:get)
    |> CompletedTasksResponse.build()
  end
end