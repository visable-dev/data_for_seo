defmodule DataForSeo.API.Serp do
  @moduledoc """
  Provides SERP API interfaces.
  """

  alias DataForSeo.{Parser, Request}

  @doc """
  Creates a task for each keyword.
  ## Options
    Keyword, or
    list of keywords, or
    a map with the `keyword => tag relation`. You can use tags later to find your result in the completed tasks.
    Also additional parameters can be passed as a keyword list: https://docs.dataforseo.com/v3/serp/google/organic/task_post/
  ## Examples
      DataForSeo.API.Serp.task_post("Schrauben")
      DataForSeo.API.Serp.task_post(["Schrauben", "Blumen"])
      DataForSeo.API.Serp.task_post(%{"Schrauben" => "123987", "Blumen" => "789231"})
      DataForSeo.API.Serp.task_post(%{"Schrauben" => "123987", "Blumen" => "789231"},  language_code: "de-DE", location_name: "20537,Hamburg,Germany", se_domain: "google.de")
  """
  def task_post(keywords_data, params \\ []) do
    case Request.post(
           "/v3/serp/google/organic/task_post",
           build_request_data(keywords_data, params)
         ) do
      {:ok, resp} ->
        {:ok, Parser.parse(resp, :task_post)}

      {:error, error} ->
        {:error, error}
    end
  end

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
  """
  def task_get(task_id, type \\ :regular) do
    case Request.get("/v3/serp/google/organic/task_get/#{type}/#{task_id}") do
      {:ok, resp} ->
        {:ok, Parser.parse(resp, :task_result)}

      {:error, error} ->
        {:error, error}
    end
  end

  # Private functions

  defp build_request_data(keywords_with_tags, params) when is_map(keywords_with_tags) do
    Enum.map(keywords_with_tags, fn {keyword, tag} ->
      Map.merge(request_params(params), %{keyword: keyword, tag: tag})
    end)
  end

  defp build_request_data(keywords, params) when is_list(keywords) do
    Enum.map(keywords, fn keyword -> Map.merge(request_params(params), %{keyword: keyword}) end)
  end

  defp build_request_data(keyword, params) when is_binary(keyword) do
    [Map.merge(request_params(params), %{keyword: keyword})]
  end

  defp request_params(params) do
    config = DataForSeo.Config.get_tuples()

    Map.merge(
      Enum.into(params, Map.new()),
      %{
        language_code: Keyword.get(params, :language_code, config[:default_language_code]),
        location_name: Keyword.get(params, :location_name, config[:default_location_name]),
        se_domain: Keyword.get(params, :se_domain, config[:default_se_domain])
      }
    )
  end
end
