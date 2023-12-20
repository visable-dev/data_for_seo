defmodule DataForSeo.API.Keywords.GoogleTrends.Explorer do
  @moduledoc """
  Provides API interfaces to Keyword Data API / Google Trends / Explore :
    https://docs.dataforseo.com/v3/keywords_data/google_trends/explore/task_post/
  """

  use DataForSeo.API.EndpointHandler

  @doc """
  This endpoint will provide you with the keyword popularity data from the ‘Explore’ feature of Google Trends.
  You can check keyword trends for Google Search, Google News, Google Images, Google Shopping, and YouTube.
  This is the Standard method of data retrieval. If you don’t need to receive data in real-time,
  this method is the best option for you. Set a task and retrieve the results when our system collects them.
  Execution time depends on the system workload.

  See https://docs.dataforseo.com/v3/keywords_data/google_trends/explore/task_post/ for available prameters.

  ## Examples

  ```
  DataForSeo.API.Keywords.GoogleTrends.Explorer.task_post(["seo api", "rank_api"], "Kyiv,Ukraine", "en", %{})
  ```
  """
  @spec task_post([String.t()], String.t() | nil, String.t() | nil, map()) :: generic_response()
  def task_post(keywords, loc_code_or_name, lang_code_or_name, extra) do
    payload =
      %{keywords: keywords}
      |> apply_location(loc_code_or_name)
      |> apply_language(lang_code_or_name)
      |> Map.merge(extra)

    post_task("/v3/keywords_data/google_trends/explore/task_post", payload)
  end

  @doc """
  Gets result for a single task in a live mode: post it and retrieve result at the same time.
  Read more: https://docs.dataforseo.com/v3/keywords_data/google_trends/explore/live/
  ## Examples
      DataForSeo.API.Keywords.GoogleTrends.Explorer.task_live("test-task-id")
  """
  @spec task_live([String.t()], String.t() | nil, String.t() | nil, map()) :: generic_response()
  def task_live(keywords, loc_code_or_name, lang_code_or_name, extra) do
    payload =
      %{keywords: keywords}
      |> apply_location(loc_code_or_name)
      |> apply_language(lang_code_or_name)
      |> Map.merge(extra)

    get_live_task("/v3/keywords_data/google_trends/explore/live", payload)
  end

  @doc """
  Gets the list of completed tasks ids.
  Read more: https://docs.dataforseo.com/v3/keywords_data/google_trends/explore/tasks_ready/
  ## Examples
  DataForSeo.API.Keywords.GoogleTrends.Explorer.tasks_ready()
  """
  @spec tasks_ready() :: generic_response()
  def tasks_ready do
    get_ready_tasks("/v3/keywords_data/google_trends/explore/tasks_ready")
  end

  @doc """
  Gets result for a single task.
  The fetched tasks are then removed from completed list. So be sure to save and process them.
  Read more: https://docs.dataforseo.com/v3/keywords_data/google_trends/explore/task_get
  ## Examples
      DataForSeo.API.Keywords.GoogleTrends.Explorer.task_get("test-task-id")
  """
  @spec task_get(String.t()) :: generic_response()
  def task_get(task_id) do
    get_one_task("/v3/keywords_data/google_trends/explore/task_get/#{task_id}")
  end
end
