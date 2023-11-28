defmodule DataForSeo.Test.ResponseFactory do
  # SERP
  def task_post_serp_google_single_response do
    get_raw_fixture(["serp", "google", "organic", "task-post-single"])
  end

  def task_post_serp_google_list_response do
    get_raw_fixture(["serp", "google", "organic", "task-post"])
  end

  def tasks_ready_serp_google_response do
    get_raw_fixture(["serp", "google", "organic", "tasks-ready"])
  end

  def task_result_serp_google_regular_response do
    get_raw_fixture(["serp", "google", "organic", "task-get-regular"])
  end

  def task_get_serp_google_location_by_country(code) do
    get_raw_fixture(["serp", "google", "locations-#{code}"])
  end

  # GOOGLE LAB
  def task_get_labs_google_categories do
    get_raw_fixture(["labs", "google", "categories"])
  end

  def task_get_labs_google_keywords_search_intent(payload) do
    # probably it doesn't make sense and it'd nice to replace dynamic items to mock more complicated cases.
    ["labs", "google", "keyword_research", "search-intent"]
    |> get_json_fixture()
    |> then(fn fixture ->
      Enum.reduce(payload, fixture, fn {k, v}, acc ->
        replace_in_fixture(acc, ["tasks", Access.all(), "data", k], v)
      end)
    end)
    |> encode_fixture()
  end

  def task_get_labs_google_keywords_for_site do
    get_raw_fixture(["labs", "google", "keyword_research", "keywords-for-site"])
  end

  def task_get_labs_google_keywords_related do
    get_raw_fixture(["labs", "google", "keyword_research", "related-keywords"])
  end

  def task_get_labs_google_keywords_ideas do
    get_raw_fixture(["labs", "google", "keyword_research", "keyword-ideas"])
  end

  def task_get_labs_google_keywords_suggestions do
    get_raw_fixture(["labs", "google", "keyword_research", "keyword-suggestions"])
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

  def task_post_keywords_google_trends_explorer do
    get_raw_fixture(["keywords", "google_trends", "explorer", "task-post"])
  end

  def tasks_ready_keywords_google_trends_explorer do
    get_raw_fixture(["keywords", "google_trends", "explorer", "tasks-ready"])
  end

  def task_get_keywords_google_trends_explorer do
    get_raw_fixture(["keywords", "google_trends", "explorer", "task-get"])
  end

  def task_get_keywords_google_trends_explorer_live do
    get_raw_fixture(["keywords", "google_trends", "explorer", "task-live"])
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
    get_fixture_base_path()
    |> Path.join(Enum.join(path, "/"))
    |> Kernel.<>(".json")
    |> File.read!()
  end

  def get_json_fixture(path = [_ | _]) do
    path
    |> get_raw_fixture()
    |> Jason.decode!()
  end

  def get_json_fixture(path) when is_binary(path) do
    path
    |> File.exists?()
    |> case do
      true ->
        path
        |> File.read!()

      false ->
        # may be it's internal path in priv/fixtures dir?
        get_fixture_base_path()
        |> Path.join(path)
        |> File.read!()
    end
    |> Jason.decode!()
  end

  def replace_in_fixture(fixture, path, value) do
    put_in(fixture, path, value)
  end

  def encode_fixture(fixture) do
    Jason.encode!(fixture)
  end

  defp get_fixture_base_path do
    :data_for_seo
    |> Application.get_env(:fixtures_path, :code.priv_dir(:data_for_seo))
    |> Path.join("fixtures")
  end
end
