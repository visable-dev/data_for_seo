defmodule DataForSeo.Api.Labs.Google.KeywordResearchTest do
  use ExUnit.Case

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
      |> Enum.filter(& &1["keyword"] == keyword)
      |> hd()
    end
  end
end
