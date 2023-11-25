defmodule RespFactory do
  def task_post_single_response do
    get_raw_fixture(["serp", "google", "organic", "task-post-single"])
  end

  def task_post_list_response do
    get_raw_fixture(["serp", "google", "organic", "task-post"])
  end

  def tasks_ready_response do
    get_raw_fixture(["serp", "google", "organic", "tasks-ready"])
  end

  def task_result_response do
    get_raw_fixture(["serp", "google", "organic", "task-get"])
  end

  def task_get_location_by_country(code) do
    get_raw_fixture(["serp", "google", "locations-#{code}"])
  end

  # GOOGLE LAB
  def task_get_labs_google_categories do
    get_raw_fixture(["labs", "google", "categories"])
  end

  def task_get_labs_google_keywords_search_intent(payload) do
    ["labs", "google", "keyword_research", "search-intent"]
    |> get_json_fixture()
    |> then(fn fixture ->
      Enum.reduce(payload, fixture, fn {k, v}, acc ->
        replace_in_fixture(acc, ["tasks", Access.all(), "data", k], v)
      end)
    end)
    |> encode_fixture()
  end

  # GOOGLE TRENDS
  def task_get_google_trends_categories do
    get_raw_fixture(["keywords", "google_trends", "categories"])
  end

  def task_get_google_trends_languages do
    get_raw_fixture(["keywords", "google_trends", "languages"])
  end

  def task_get_google_trend_locations do
    get_raw_fixture(["keywords", "google_trends", "locations"])
  end

  def task_get_google_trend_locations_by_country(_) do
    # same fixture at the moment b/c there are no difference with all locations list
    # only testing a success routing to the url and response format
    get_raw_fixture(["keywords", "google_trends", "locations"])
  end

  # GOOGLE ADS
  def task_get_google_ads_locations do
    get_raw_fixture(["keywords", "google_ads", "locations"])
  end

  def task_get_google_ads_languages do
    get_raw_fixture(["keywords", "google_ads", "languages"])
  end

  # FIXTURE METHODS
  def get_raw_fixture(path = [_ | _]) do
    :data_for_seo
    |> :code.priv_dir()
    |> Path.join(Enum.join(["fixtures" | path], "/"))
    |> Kernel.<>(".json")
    |> File.read!()
  end

  def get_json_fixture(path = [_ | _]) do
    path
    |> get_raw_fixture()
    |> Jason.decode!()
  end

  def replace_in_fixture(fixture, path, value) do
    put_in(fixture, path, value)
  end

  def encode_fixture(fixture) do
    Jason.encode!(fixture)
  end
end
