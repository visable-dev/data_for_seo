defmodule DataForSeo.API.Serp do
  @moduledoc """
  Provides SERP API interfaces.
  """

  alias DataForSeo.Client
  alias DataForSeo.Parser

  @doc """
  Creates a task for each keyword.

  ## Parameters

    - `params` - list of maps for multiple tasks, or single map fir one task.

    See https://docs.dataforseo.com/v3/serp/google/organic/task_post/ for available prameters.

  ## Examples

  ```
  DataForSeo.API.Serp.task_post([%{keyword: "Schrauben", tag: "tag_123", language_code: "de", priority: 1, location_name: "Hamburg,Hamburg,Germany", se_domain: "google.de"}])
  DataForSeo.API.Serp.task_post(%{keyword: "Schrauben", tag: "tag_123", language_code: "de", priority: 1, location_name: "Hamburg,Hamburg,Germany", se_domain: "google.de"})
  ```
  """
  def task_post(params) when is_list(params) do
    Client.post("/v3/serp/google/organic/task_post", params)
    |> Client.validate_status_code()
    |> Client.decode_json_response()
    |> case do
      {:ok, resp} ->
        {:ok, Parser.parse(resp, :task_post)}

      {:error, error} ->
        {:error, error}
    end
  end

  def task_post(params) when is_map(params), do: task_post([params])

  @doc """
  Gets the list of completed tasks ids.
  ## Examples
      DataForSeo.API.Serp.tasks_ready()
  """
  def tasks_ready do
    Client.get("/v3/serp/google/organic/tasks_ready")
    |> Client.validate_status_code()
    |> Client.decode_json_response()
    |> case do
      {:ok, resp} ->
        {:ok, Parser.parse(resp, :tasks_ready)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Gets result for a single task. The fetched tasks are then removed from completed list. So be sure to save and process them.
  ## Examples
      DataForSeo.API.Serp.task_get("test-task-id")
  """
  def task_get(task_id, opts \\ []) do
    {type, _opts} = Keyword.pop(opts, :type, :regular)

    Client.get("/v3/serp/google/organic/task_get/#{type}/#{task_id}")
    |> Client.validate_status_code()
    |> Client.decode_json_response()
    |> case do
      {:ok, resp} ->
        {:ok, Parser.parse(resp, :task_result)}

      {:error, error} ->
        {:error, error}
    end
  end
end
