defmodule DataForSeo.Api.Keywords.GoogleTrends.ExplorerTest do
  use ExUnit.Case

  alias DataForSeo.API.Keywords.GoogleTrends.Explorer

  import DataForSeo.Test.ResponseFactory

  setup do
    bypass = Bypass.open()

    DataForSeo.Config.add(:process, base_url: "http://localhost:#{bypass.port}")

    {:ok, bypass: bypass}
  end

  describe "task_post/4 with a string keyword" do
    test "it makes task_post POST request with params", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/keywords_data/google_trends/explore/task_post" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        {:ok, body, _} = Plug.Conn.read_body(conn)

        assert(
          body ==
            Jason.encode!([
              %{
                keywords: ["bananas", "apples"],
                language_code: "en",
                location_name: "San Francisco,California,United States",
                type: "youtube"
              }
            ])
        )

        Plug.Conn.resp(
          conn,
          200,
          task_post_keywords_google_trends_explorer()
        )
      end)

      assert {:ok, resp} =
               Explorer.task_post(
                 ["bananas", "apples"],
                 "San Francisco,California,United States",
                 "en",
                 %{type: "youtube"}
               )

      assert %{"tasks" => tasks, "tasks_count" => 1} = resp
      task = tasks |> hd
      assert task["id"] == "02122119-1535-0170-0000-0228cf083d8e"
      assert Enum.count(tasks) == 1
    end
  end

  describe "tasks_ready/0" do
    test "it returns a list of completed tasks ids", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "GET" = conn.method
        assert "/v3/keywords_data/google_trends/explore/tasks_ready" = conn.request_path

        Plug.Conn.resp(
          conn,
          200,
          tasks_ready_keywords_google_trends_explorer()
        )
      end)

      assert {:ok, %{"tasks" => [%{"result" => results}]}} = Explorer.tasks_ready()

      task_ids = Enum.map(results, & &1["id"])

      assert Enum.member?(task_ids, "10311535-0696-0093-0000-8fe3770f079b")
      assert Enum.member?(task_ids, "11111403-0696-0110-0000-c69794ecf661")
      assert Enum.member?(task_ids, "11201044-0696-0110-0000-9f560a19543e")
      assert length(task_ids) == 3
    end
  end

  describe "task_get/2" do
    test "returns task as map", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "GET" = conn.method

        assert "/v3/keywords_data/google_trends/explore/task_get/04212120-1535-0170-0000-46acef0a7cac" =
                 conn.request_path

        Plug.Conn.resp(
          conn,
          200,
          task_get_keywords_google_trends_explorer()
        )
      end)

      resp = Explorer.task_get("04212120-1535-0170-0000-46acef0a7cac")

      assert {:ok, response} = resp
      task = response["tasks"] |> hd()
      result = task["result"] |> hd()
      assert ["seo api", "rank api"] = result["keywords"]
    end
  end

  describe "task_live/4" do
    test "returns task as map", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/keywords_data/google_trends/explore/live" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        {:ok, body, _} = Plug.Conn.read_body(conn)

        assert(
          body ==
            Jason.encode!([
              %{
                keywords: ["seo api"]
              }
            ])
        )

        Plug.Conn.resp(
          conn,
          200,
          task_get_keywords_google_trends_explorer_live()
        )
      end)

      assert {:ok, resp} = Explorer.task_live(["seo api"], nil, nil, %{})

      assert %{"tasks" => tasks, "tasks_count" => 1} = resp
      task = tasks |> hd
      assert task["id"] == "04212140-1535-0173-0000-8209149d8105"
      assert Enum.count(tasks) == 1
    end
  end
end
