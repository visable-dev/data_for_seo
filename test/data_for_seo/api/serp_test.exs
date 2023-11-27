defmodule DataForSeo.Api.SerpTest do
  use ExUnit.Case

  alias DataForSeo.API.Serp

  import RespFactory

  setup do
    bypass = Bypass.open()

    DataForSeo.Config.add(:process, base_url: "http://localhost:#{bypass.port}")

    {:ok, bypass: bypass}
  end

  describe "task_post/1 with a string keyword" do
    test "it makes task_post POST request with params", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/serp/google/organic/task_post" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        {:ok, body, _} = Plug.Conn.read_body(conn)

        assert(
          body ==
            Jason.encode!([
              %{
                keyword: "Schrauben",
                language_code: "en",
                location_name: "San Francisco,California,United States",
                se_domain: "google.com"
              }
            ])
        )

        Plug.Conn.resp(
          conn,
          200,
          task_post_serp_google_single_response()
        )
      end)

      assert {:ok, resp} =
               Serp.task_post(%{
                 keyword: "Schrauben",
                 language_code: "en",
                 location_name: "San Francisco,California,United States",
                 se_domain: "google.com"
               })

      assert %{"tasks" => tasks, "tasks_count" => 1} = resp
      task = tasks |> hd
      assert task["id"] == "01291721-1535-0066-0000-8f0635c0dc89"
      assert task["data"]["keyword"] == "Schrauben"
      assert Enum.count(tasks) == 1
    end
  end

  describe "task_post/1 with a list of keywords" do
    test "it makes task_post POST request with params", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/serp/google/organic/task_post" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        {:ok, body, _} = Plug.Conn.read_body(conn)

        assert(
          body ==
            Jason.encode!([
              %{
                keyword: "Schrauben",
                language_code: "en",
                location_name: "San Francisco,California,United States",
                se_domain: "google.com"
              },
              %{
                keyword: "Blumen",
                language_code: "en",
                location_name: "San Francisco,California,United States",
                se_domain: "google.com"
              }
            ])
        )

        Plug.Conn.resp(
          conn,
          200,
          task_post_serp_google_list_response()
        )
      end)

      assert {:ok, resp} =
               Serp.task_post([
                 %{
                   keyword: "Schrauben",
                   language_code: "en",
                   location_name: "San Francisco,California,United States",
                   se_domain: "google.com"
                 },
                 %{
                   keyword: "Blumen",
                   language_code: "en",
                   location_name: "San Francisco,California,United States",
                   se_domain: "google.com"
                 }
               ])

      assert %{"tasks" => tasks, "tasks_count" => 2} = resp
      [task1, task2] = tasks

      assert task1["id"] == "01291721-1535-0066-0000-8f0635c0dc89"
      assert task1["data"]["keyword"] == "Schrauben"

      assert task2["id"] == "01291721-1535-0066-0000-2e7a8bf7302c"
      assert task2["data"]["keyword"] == "Blumen"
    end
  end

  describe "tasks_ready/0" do
    test "it returns a list of completed tasks ids", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "GET" = conn.method
        assert "/v3/serp/google/organic/tasks_ready" = conn.request_path

        Plug.Conn.resp(
          conn,
          200,
          tasks_ready_serp_google_response()
        )
      end)

      assert {:ok, %{"tasks" => [%{"result" => results}]}} = Serp.tasks_ready()

      task_ids = Enum.map(results, & &1["id"])

      assert Enum.member?(task_ids, "11081554-0696-0066-0000-27e68ec15871")
      assert Enum.member?(task_ids, "11151406-0696-0066-0000-c4ece317cdb2")
    end
  end

  describe "task_get/2" do
    test "returns task as map", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "GET" = conn.method

        assert "/v3/serp/google/organic/task_get/regular/03101638-9334-0066-0000-44b65a6119fb" =
                 conn.request_path

        Plug.Conn.resp(
          conn,
          200,
          task_result_serp_google_regular_response()
        )
      end)

      resp = Serp.task_get("03101638-9334-0066-0000-44b65a6119fb")

      assert {:ok, response} = resp
      task = response["tasks"] |> hd()
      result = task["result"] |> hd()
      item = result["items"] |> hd()

      assert item["domain"] == "www.bookingbuddy.com"
    end
  end
end
