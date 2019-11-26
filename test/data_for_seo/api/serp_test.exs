defmodule DataForSeo.Api.SerpTest do
  use ExUnit.Case
  import FakeServer

  alias DataForSeo.API.Serp

  describe "create_tasks/5" do
    test_with_server "it makes create_tasks POST request with params" do
      DataForSeo.Config.add(:process, base_url: FakeServer.http_address())
      route("/v2/srp_tasks_post", RespFactory.build(:create_tasks))

      Serp.create_tasks(%{"Schrauben" => 1234}, "German", "Germany", "google.de", [])

      assert(
        request_received(
          "/v2/srp_tasks_post",
          method: "POST",
          query: %{
            data: %{"Schrauben" => 1234},
            se_language: "German",
            loc_name_canonical: "Germany",
            se_name: "google.de",
            priority: 1
          },
          count: 1
        )
      )
    end

    test_with_server "it returns CreateTasksResponse struct" do
      DataForSeo.Config.add(:process, base_url: FakeServer.http_address())
      route("/v2/srp_tasks_post", RespFactory.build(:create_tasks))

      resp = Serp.create_tasks(%{"Schrauben" => 1234}, "German", "Germany", "google.de", [])

      assert(
        %DataForSeo.Serp.CreateTasksResponse{
          error: nil,
          results: %{
            "Schrauben" => %DataForSeo.Serp.CreatedTask{
              key_id: 212_348_146,
              loc_id: 2276,
              post_id: "Schrauben",
              post_key: "Schrauben",
              se_id: 25,
              status: "ok",
              task_id: 12_620_846_274
            }
          },
          status: "ok"
        } = resp
      )
    end
  end

  describe "completed_tasks/0" do
    test_with_server "it makes completed_tasks GET request" do
      DataForSeo.Config.add(:process, base_url: FakeServer.http_address())
      route("/v2/srp_tasks_get", RespFactory.build(:completed_tasks))

      Serp.completed_tasks()

      assert request_received("/v2/srp_tasks_get", method: "GET", count: 1)
    end

    test_with_server "it returns CompletedTasksResponse struct" do
      DataForSeo.Config.add(:process, base_url: FakeServer.http_address())
      route("/v2/srp_tasks_get", RespFactory.build(:completed_tasks))

      resp = Serp.completed_tasks()

      assert(
        %DataForSeo.Serp.CompletedTasksResponse{
          error: nil,
          results: [
            %DataForSeo.Serp.CompletedTask{
              key_id: 212_348_146,
              loc_id: 2276,
              post_id: "Schrauben",
              post_key: "Schrauben",
              result_extra: "people_also_ask,images,top_stories,local_pack",
              result_se_check_url:
                "https://www.google.de/search?q=Schrauben&num=100&hl=de&gl=DE&gws_rd=cr&ie=UTF-8&oe=UTF-8&uule=w+CAIQIFISCWu-scIecppHEVvlkY5rXeh1",
              result_spell: "",
              result_spell_type: "",
              results_count: 58_200_000,
              se_id: 25,
              task_id: 12_620_846_274
            }
          ],
          status: "ok"
        } = resp
      )
    end
  end

  describe "task_result/1" do
    test_with_server "it makes task_result GET request with task_id" do
      DataForSeo.Config.add(:process, base_url: FakeServer.http_address())
      route("/v2/srp_tasks_get/1", RespFactory.build(:task_result))

      Serp.task_result(1)

      assert request_received("/v2/srp_tasks_get/1", method: "GET", count: 1)
    end

    test_with_server "it returns TaskResultResponse struct" do
      DataForSeo.Config.add(:process, base_url: FakeServer.http_address())
      route("/v2/srp_tasks_get/1", RespFactory.build(:task_result))

      resp = Serp.task_result(1)

      assert(
        %DataForSeo.Serp.TaskResultResponse{
          error: nil,
          results: %{
            "extra" => %{
              "related" => [
                [
                  "schrauben shop kleinmengen",
                  "schrauben spax",
                  "schrauben versandkostenfrei",
                  "schrauben holz",
                  "schrauben maße",
                  "schrauben bezeichnung",
                  "torx schrauben",
                  "schrauben amazon"
                ]
              ]
            },
            "organic" => [
              %{
                "key_id" => 212_348_146,
                "loc_id" => 2276,
                "post_id" => "Schrauben",
                "post_key" => "Schrauben",
                "result_breadcrumb" => "https://online-schrauben.de › shop",
                "result_datetime" => "2019-11-19 10:10:52 +00:00",
                "result_extra" => "people_also_ask,images,top_stories,local_pack",
                "result_highlighted" => ["Schrauben"],
                "result_position" => 1,
                "result_se_check_url" =>
                  "https://www.google.de/search?q=Schrauben&num=100&hl=de&gl=DE&gws_rd=cr&ie=UTF-8&oe=UTF-8&uule=w+CAIQIFISCWu-scIecppHEVvlkY5rXeh1",
                "result_snippet" =>
                  "Schrauben online kaufen ✓ Großes Sortiment ✓ Faire Preise ✓ Schnelle Lieferung ✓ Beratung von Experten ✓ Über 25 Jahre.",
                "result_snippet_extra" => "",
                "result_spell" => "",
                "result_spell_type" => "",
                "result_stat" => [],
                "result_title" => "Online Schrauben",
                "result_url" => "https://online-schrauben.de/shop/",
                "results_count" => 58_200_000,
                "se_id" => 25,
                "task_id" => 12_620_846_274
              },
              %{
                "key_id" => 212_348_146,
                "loc_id" => 2276,
                "post_id" => "Schrauben",
                "post_key" => "Schrauben",
                "task_id" => 12_620_846_274
              }
            ],
            "paid" => []
          },
          status: "ok"
        } = resp
      )
    end

    test_with_server "it doesn't raise exception whe error commes from DataForSeo" do
      DataForSeo.Config.add(:process, base_url: FakeServer.http_address())
      route("/v2/srp_tasks_get/1", RespFactory.build(:bad))

      result = Serp.task_result(1)
      assert {:error, %{"code" => _, "message" => _}} = result
    end
  end
end
