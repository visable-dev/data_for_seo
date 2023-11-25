defmodule DataForSeo.Api.Labs.Google.KeywordResearchTest do
  use ExUnit.Case

  # Notes on testing.
  # There is no a lot of sense to test fixture since we know it was returned and correct.
  # However it could be useful it each type of data will have it's own structs. Then it'll make sense
  # if data parsed and mapped properly. Right now it's enough to test that payload is valid.
  # I tried to test more on search_intent/3, but it's useless b/c fixtures are stale.
  # Just checking now if it returns a proper decoded fixture as response

  alias DataForSeo.API.Labs.Google.KeywordResearch

  import RespFactory

  setup do
    bypass = Bypass.open()

    DataForSeo.Config.add(:process, base_url: "http://localhost:#{bypass.port}")

    {:ok, bypass: bypass}
  end

  describe "search_intent/3" do
    test "request by language code", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/dataforseo_labs/google/search_intent/live" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        assert {:ok, body, _} = Plug.Conn.read_body(conn)
        payload = Jason.decode!(body)
        assert payload["keywords"] == ["milk"]
        assert payload["language_code"] == "en"
        refute Map.has_key?(payload, "language_name")
        refute Map.has_key?(payload, "tag")

        Plug.Conn.resp(
          conn,
          200,
          task_get_labs_google_keywords_search_intent(payload)
        )
      end)

      {:ok, response} = KeywordResearch.search_intent(["milk"], "en", nil)
      assert %{"tasks" => [task | _], "tasks_count" => 1} = response
      assert task["id"] == "02271900-1535-0541-0000-2ab771deb8e2"
      assert task["data"]["keywords"] == ["milk"]

      assert %{
               "keyword" => "milk",
               "keyword_intent" => %{"label" => "commercial", "probability" => 0.49751797},
               "secondary_keyword_intents" => [
                 %{"label" => "transactional", "probability" => 0.37083894},
                 %{"label" => "informational", "probability" => 0.30781138}
               ]
             } = find_intent_in_task_response_for_keyword(task, "milk")
    end

    test "request by language name with tag", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/dataforseo_labs/google/search_intent/live" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        assert {:ok, body, _} = Plug.Conn.read_body(conn)
        payload = Jason.decode!(body)
        assert payload["keywords"] == ["audi a7"]
        assert payload["tag"] == "mytag"
        assert payload["language_name"] == "English"
        refute Map.has_key?(payload, "language_code")

        Plug.Conn.resp(
          conn,
          200,
          task_get_labs_google_keywords_search_intent(payload)
        )
      end)

      {:ok, response} = KeywordResearch.search_intent(["audi a7"], "English", "mytag")
      assert %{"tasks" => [task | _], "tasks_count" => 1} = response
      assert task["id"] == "02271900-1535-0541-0000-2ab771deb8e2"
      assert task["data"]["keywords"] == ["audi a7"]

      assert %{
               "keyword" => "audi a7",
               "keyword_intent" => %{"label" => "commercial", "probability" => 1},
               "secondary_keyword_intents" => nil
             } = find_intent_in_task_response_for_keyword(task, "audi a7")
    end

    defp find_intent_in_task_response_for_keyword(task, keyword) do
      task
      |> Map.get("result")
      |> hd()
      |> Map.get("items")
      |> Enum.filter(&(&1["keyword"] == keyword))
      |> hd()
    end
  end

  describe "keywords_for_site/4" do
    test "request by language code and loc code", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/dataforseo_labs/google/keywords_for_site/live" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        assert {:ok, body, _} = Plug.Conn.read_body(conn)
        payload = Jason.decode!(body)
        assert payload["target"] == "apple.com"
        assert payload["language_code"] == "en"
        assert payload["location_code"] == 3346
        # shouldn't be any other data in payload
        assert map_size(payload) == 3

        Plug.Conn.resp(
          conn,
          200,
          task_get_labs_google_keywords_for_site()
        )
      end)

      {:ok, response} = KeywordResearch.keywords_for_site("apple.com", 3346, "en", %{})
      assert %{"tasks" => [task | _], "tasks_count" => 1} = response
      assert task["id"] == "03231831-1535-0398-0000-86e0a30305cb"
      assert task["data"]["target"] == "apple.com"
    end

    test "request by language name and loc name with extra filters", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/dataforseo_labs/google/keywords_for_site/live" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        assert {:ok, body, _} = Plug.Conn.read_body(conn)
        payload = Jason.decode!(body)
        assert payload["target"] == "apple.com"
        assert payload["language_name"] == "English"
        assert payload["location_name"] == "United Kingdom"
        assert payload["include_serp_info"] == true
        assert payload["limit"] == 100
        # shouldn't be any other data in payload
        assert map_size(payload) == 5

        Plug.Conn.resp(
          conn,
          200,
          task_get_labs_google_keywords_for_site()
        )
      end)

      {:ok, response} =
        KeywordResearch.keywords_for_site("apple.com", "United Kingdom", "English", %{
          include_serp_info: true,
          limit: 100
        })

      assert %{"tasks" => [task | _], "tasks_count" => 1} = response
      assert task["id"] == "03231831-1535-0398-0000-86e0a30305cb"
      assert task["data"]["target"] == "apple.com"
    end
  end

  describe "related_keywords/4" do
    test "request by language code and loc code", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/dataforseo_labs/google/related_keywords/live" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        assert {:ok, body, _} = Plug.Conn.read_body(conn)
        payload = Jason.decode!(body)
        assert payload["keyword"] == "apples"
        assert payload["language_code"] == "en"
        assert payload["location_code"] == 3346
        # shouldn't be any other data in payload
        assert map_size(payload) == 3

        Plug.Conn.resp(
          conn,
          200,
          task_get_labs_google_keywords_related()
        )
      end)

      {:ok, response} = KeywordResearch.related_keywords("apples", 3346, "en", %{})
      assert %{"tasks" => [task | _], "tasks_count" => 1} = response
      assert task["id"] == "03210009-4426-0387-0000-5a33a48f3334"
    end

    test "request by language name and loc name with extra filters", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/dataforseo_labs/google/related_keywords/live" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        assert {:ok, body, _} = Plug.Conn.read_body(conn)
        payload = Jason.decode!(body)
        assert payload["keyword"] == "bananas"
        assert payload["language_name"] == "English"
        assert payload["location_name"] == "United Kingdom"
        assert payload["limit"] == 5
        # shouldn't be any other data in payload
        assert map_size(payload) == 4

        Plug.Conn.resp(
          conn,
          200,
          task_get_labs_google_keywords_related()
        )
      end)

      {:ok, response} =
        KeywordResearch.related_keywords("bananas", "United Kingdom", "English", %{limit: 5})

      assert %{"tasks" => [task | _], "tasks_count" => 1} = response
      assert task["id"] == "03210009-4426-0387-0000-5a33a48f3334"
    end
  end

  describe "keyword_ideas/4" do
    test "request by language code and loc code", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/dataforseo_labs/google/keyword_ideas/live" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        assert {:ok, body, _} = Plug.Conn.read_body(conn)
        payload = Jason.decode!(body)
        assert payload["keywords"] == ["phone", "watch"]
        assert payload["language_code"] == "en"
        assert payload["location_code"] == 3346
        # shouldn't be any other data in payload
        assert map_size(payload) == 3

        Plug.Conn.resp(
          conn,
          200,
          task_get_labs_google_keywords_ideas()
        )
      end)

      {:ok, response} = KeywordResearch.keyword_ideas(["phone", "watch"], 3346, "en", %{})
      assert %{"tasks" => [task | _], "tasks_count" => 1} = response
      assert task["id"] == "03231838-1535-0400-0000-21ff7a0ecead"
    end

    test "request by language name and loc name with extra filters", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/dataforseo_labs/google/keyword_ideas/live" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        assert {:ok, body, _} = Plug.Conn.read_body(conn)
        payload = Jason.decode!(body)
        assert payload["keywords"] == ["bananas", "fruits"]
        assert payload["language_name"] == "English"
        assert payload["location_name"] == "United Kingdom"
        assert payload["limit"] == 5
        # shouldn't be any other data in payload
        assert map_size(payload) == 4

        Plug.Conn.resp(
          conn,
          200,
          task_get_labs_google_keywords_ideas()
        )
      end)

      {:ok, response} =
        KeywordResearch.keyword_ideas(["bananas", "fruits"], "United Kingdom", "English", %{
          limit: 5
        })

      assert %{"tasks" => [task | _], "tasks_count" => 1} = response
      assert task["id"] == "03231838-1535-0400-0000-21ff7a0ecead"
    end
  end

  describe "keyword_suggestions/4" do
    test "request by language code and loc code", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/dataforseo_labs/google/keyword_suggestions/live" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        assert {:ok, body, _} = Plug.Conn.read_body(conn)
        payload = Jason.decode!(body)
        assert payload["keyword"] == "apples"
        assert payload["language_code"] == "en"
        assert payload["location_code"] == 3346
        # shouldn't be any other data in payload
        assert map_size(payload) == 3

        Plug.Conn.resp(
          conn,
          200,
          task_get_labs_google_keywords_suggestions()
        )
      end)

      {:ok, response} = KeywordResearch.keyword_suggestions("apples", 3346, "en", %{})
      assert %{"tasks" => [task | _], "tasks_count" => 1} = response
      assert task["id"] == "03231835-1535-0399-0000-cb09ada1b499"
    end

    test "request by language name and loc name with extra filters", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/dataforseo_labs/google/keyword_suggestions/live" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        assert {:ok, body, _} = Plug.Conn.read_body(conn)
        payload = Jason.decode!(body)
        assert payload["keyword"] == "bananas"
        assert payload["language_name"] == "English"
        assert payload["location_name"] == "United Kingdom"
        assert payload["limit"] == 5
        # shouldn't be any other data in payload
        assert map_size(payload) == 4

        Plug.Conn.resp(
          conn,
          200,
          task_get_labs_google_keywords_suggestions()
        )
      end)

      {:ok, response} =
        KeywordResearch.keyword_suggestions("bananas", "United Kingdom", "English", %{limit: 5})

      assert %{"tasks" => [task | _], "tasks_count" => 1} = response
      assert task["id"] == "03231835-1535-0399-0000-cb09ada1b499"
    end
  end
end
