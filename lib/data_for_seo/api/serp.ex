defmodule DataForSeo.API.Serp do
  @moduledoc """
  Provides SERP API interfaces.
  """

  import DataForSeo.API.Base
  alias DataForSeo.Serp.{CreateTasksResponse, CompletedTasksResponse, TaskResultResponse}

  @doc """
  Creates a task for each key.
  ## Options
    The `keys_with_post_ids` is a map with the key => post_id. You will need post_id later
    to find your result in the completed tasks.
    * `:global` - configuration is shared for all processes.
    * `:process` - configuration is isolated for each process.
  ## Examples
      DataForSeo.API.Serp.create_tasks(%{"Schrauben" => 123987}, "German", "20537,Hamburg,Germany", "google.de", [])
  """
  def create_tasks(
        keys_with_post_ids,
        se_language,
        loc_name_canonical,
        se_name,
        optional_params
      )
      when is_map(keys_with_post_ids) do
    # TODO refactor this
    all_params =
      Enum.reduce(keys_with_post_ids, %{}, fn {key, post_id}, acc ->
        task_params =
          Map.merge(
            Enum.into(optional_params, Map.new()),
            %{
              key: key,
              se_language: se_language,
              loc_name_canonical: loc_name_canonical,
              se_name: se_name
            }
          )

        Map.put(acc, post_id, task_params)
      end)

    case request(:post, "v2/srp_tasks_post", data: all_params) do
      {:ok, map} ->
        CreateTasksResponse.build(map)

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Gets completed tasks. All returned tasks are then removed from completed list. So be sure to save and process them.
  ## Examples
      DataForSeo.API.Serp.completed_tasks()
  """
  def completed_tasks do
    case request(:get, "v2/srp_tasks_get") do
      {:ok, map} ->
        CompletedTasksResponse.build(map)

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Gets result for a single task.
  ## Examples
      DataForSeo.API.Serp.completed_tasks()
  """
  def task_result(task_id) do
    case request(:get, "v2/srp_tasks_get/#{task_id}") do
      {:ok, map} ->
        TaskResultResponse.build(map)

      {:error, error} ->
        {:error, error}
    end
  end
end
