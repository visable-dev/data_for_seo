defmodule DataForSeo.API.Serp do
  @moduledoc """
  Provides SERP API interfaces.
  """

  alias DataForSeo.{Parser, Request}

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
    case Request.post("/v3/serp/google/organic/task_post", params) do
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
    case Request.get("/v3/serp/google/organic/tasks_ready") do
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
      DataForSeo.API.Serp.task_get("test-task-id", parse: false)
  """
  def task_get(task_id, opts \\ []) do
    {type, opts} = Keyword.pop(opts, :type, :regular)
    {parse, _opts} = Keyword.pop(opts, :parse, true)
    parse_strategy = if parse, do: :task_result, else: :raw_task_result

    case Request.get("/v3/serp/google/organic/task_get/#{type}/#{task_id}") do
      {:ok, resp} ->
        {:ok, Parser.parse(resp, parse_strategy)}

      {:error, error} ->
        {:error, error}
    end
  end
end
