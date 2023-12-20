defmodule DataForSeo.API.SERP.Youtube.Organic do
  @moduledoc """
  Provides SERP Youtube API interfaces to organic search results.
  """

  use DataForSeo.API.EndpointHandler

  @doc "Post task"
  def task_post(params) when is_list(params) do
    post_task("/v3/serp/youtube/organic/task_post", params)
  end

  def task_post(params) when is_map(params), do: task_post([params])

  @doc "Get ready tasks"
  def tasks_ready do
    get_ready_tasks("/v3/serp/youtube/organic/tasks_ready")
  end

  @doc "Get single task"
  def task_get(task_id, opts \\ []) do
    {type, _opts} = Keyword.pop(opts, :type, :regular)
    get_one_task("/v3/serp/youtube/organic/task_get/#{type}/#{task_id}")
  end
end
