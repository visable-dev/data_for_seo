defmodule DataForSeo.Api.SerpTest do
  use ExUnit.Case

  alias DataForSeo.API.Serp

  setup do
    bypass = Bypass.open()

    DataForSeo.Config.add(:process, base_url: "http://localhost:#{bypass.port}")

    {:ok, bypass: bypass}
  end

  describe "create_tasks/1 with a string keyword" do
    test "it makes create_tasks POST request with params", %{bypass: bypass} do
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
          "{\"version\":\"0.1.20200310\",\"status_code\":20000,\"status_message\":\"Ok.\",\"time\":\"0.0617sec.\",\"cost\":0.00075,\"tasks_count\":1,\"tasks_error\":0,\"tasks\":[{\"id\":\"03101544-9334-0066-0000-f1b58404c15a\",\"status_code\":20100,\"status_message\":\"TaskCreated.\",\"time\":\"0.0053sec.\",\"cost\":0.00075,\"result_count\":0,\"path\":[\"v3\",\"serp\",\"google\",\"organic\",\"task_post\"],\"data\":{\"api\":\"serp\",\"function\":\"task_post\",\"se\":\"google\",\"se_type\":\"organic\",\"keyword\":\"Schrauben\",\"language_code\":\"en\",\"location_name\":\"San Francisco,California,United States\",\"se_domain\":\"google.com\",\"device\":\"desktop\",\"os\":\"windows\"},\"result\":null}]}"
        )
      end)

      resp = Serp.create_tasks("Schrauben")

      assert {:ok, arr} = resp

      assert %DataForSeo.Serp.CreatedTask{
               cost: 7.5e-4,
               id: "03101544-9334-0066-0000-f1b58404c15a",
               keyword: "Schrauben",
               status_code: 20100,
               status_message: "TaskCreated.",
               tag: nil
             } = List.first(arr)
    end
  end

  describe "create_tasks/1 with a list of keywords" do
    test "it makes create_tasks POST request with params", %{bypass: bypass} do
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
          "{\"version\":\"0.1.20200310\",\"status_code\":20000,\"status_message\":\"Ok.\",\"time\":\"0.0671sec.\",\"cost\":0.0015,\"tasks_count\":2,\"tasks_error\":0,\"tasks\":[{\"id\":\"03101557-9334-0066-0000-13bd3f91bb7f\",\"status_code\":20100,\"status_message\":\"TaskCreated.\",\"time\":\"0.0041sec.\",\"cost\":0.00075,\"result_count\":0,\"path\":[\"v3\",\"serp\",\"google\",\"organic\",\"task_post\"],\"data\":{\"api\":\"serp\",\"function\":\"task_post\",\"se\":\"google\",\"se_type\":\"organic\",\"keyword\":\"Schrauben\",\"language_code\":\"en\",\"location_name\":\"San Francisco,California,United States\",\"se_domain\":\"google.com\",\"device\":\"desktop\",\"os\":\"windows\"},\"result\":null},{\"id\":\"03101557-9334-0066-0000-42d70ed95cf1\",\"status_code\":20100,\"status_message\":\"TaskCreated.\",\"time\":\"0.0039sec.\",\"cost\":0.00075,\"result_count\":0,\"path\":[\"v3\",\"serp\",\"google\",\"organic\",\"task_post\"],\"data\":{\"api\":\"serp\",\"function\":\"task_post\",\"se\":\"google\",\"se_type\":\"organic\",\"keyword\":\"Blumen\",\"language_code\":\"en\",\"location_name\":\"San Francisco,California,United States\",\"se_domain\":\"google.com\",\"device\":\"desktop\",\"os\":\"windows\"},\"result\":null}]}"
        )
      end)

      resp = Serp.create_tasks(["Schrauben", "Blumen"])

      assert {:ok, arr} = resp

      assert %DataForSeo.Serp.CreatedTask{
               cost: 7.5e-4,
               id: "03101557-9334-0066-0000-13bd3f91bb7f",
               keyword: "Schrauben",
               status_code: 20100,
               status_message: "TaskCreated.",
               tag: nil
             } = List.first(arr)

      assert %DataForSeo.Serp.CreatedTask{
               cost: 7.5e-4,
               id: "03101557-9334-0066-0000-42d70ed95cf1",
               keyword: "Blumen",
               status_code: 20100,
               status_message: "TaskCreated.",
               tag: nil
             } = List.last(arr)
    end
  end

  describe "create_tasks/1 with a list keywords map" do
    test "it makes create_tasks POST request with params", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/serp/google/organic/task_post" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        {:ok, body, _} = Plug.Conn.read_body(conn)

        assert(
          body ==
            Jason.encode!([
              %{
                keyword: "Blumen",
                tag: "test-tag-2",
                language_code: "en",
                location_name: "San Francisco,California,United States",
                se_domain: "google.com"
              },
              %{
                keyword: "Schrauben",
                tag: "test-tag-1",
                language_code: "en",
                location_name: "San Francisco,California,United States",
                se_domain: "google.com"
              }
            ])
        )

        Plug.Conn.resp(
          conn,
          200,
          "{\"version\":\"0.1.20200310\",\"status_code\":20000,\"status_message\":\"Ok.\",\"time\":\"0.0361sec.\",\"cost\":0.0015,\"tasks_count\":2,\"tasks_error\":0,\"tasks\":[{\"id\":\"03101628-9334-0066-0000-df28eb43dfd2\",\"status_code\":20100,\"status_message\":\"TaskCreated.\",\"time\":\"0.0037sec.\",\"cost\":0.00075,\"result_count\":0,\"path\":[\"v3\",\"serp\",\"google\",\"organic\",\"task_post\"],\"data\":{\"api\":\"serp\",\"function\":\"task_post\",\"se\":\"google\",\"se_type\":\"organic\",\"keyword\":\"Blumen\",\"language_code\":\"en\",\"location_name\":\"San Francisco,California,United States\",\"se_domain\":\"google.com\",\"tag\":\"test-tag-2\",\"device\":\"desktop\",\"os\":\"windows\"},\"result\":null},{\"id\":\"03101628-9334-0066-0000-34ca7793d74a\",\"status_code\":20100,\"status_message\":\"TaskCreated.\",\"time\":\"0.0046sec.\",\"cost\":0.00075,\"result_count\":0,\"path\":[\"v3\",\"serp\",\"google\",\"organic\",\"task_post\"],\"data\":{\"api\":\"serp\",\"function\":\"task_post\",\"se\":\"google\",\"se_type\":\"organic\",\"keyword\":\"Schrauben\",\"language_code\":\"en\",\"location_name\":\"San Francisco,California,United States\",\"se_domain\":\"google.com\",\"tag\":\"test-tag-1\",\"device\":\"desktop\",\"os\":\"windows\"},\"result\":null}]}"
        )
      end)

      resp = Serp.create_tasks(%{"Schrauben" => "test-tag-1", "Blumen" => "test-tag-2"})

      assert {:ok, arr} = resp

      assert %DataForSeo.Serp.CreatedTask{
               cost: 7.5e-4,
               id: "03101628-9334-0066-0000-df28eb43dfd2",
               keyword: "Blumen",
               status_code: 20100,
               status_message: "TaskCreated.",
               tag: "test-tag-2"
             } = List.first(arr)

      assert %DataForSeo.Serp.CreatedTask{
               cost: 7.5e-4,
               id: "03101628-9334-0066-0000-34ca7793d74a",
               keyword: "Schrauben",
               status_code: 20100,
               status_message: "TaskCreated.",
               tag: "test-tag-1"
             } = List.last(arr)
    end
  end

  describe "create_tasks/2 with a string keyword and additional params" do
    test "it makes create_tasks POST request with params", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/v3/serp/google/organic/task_post" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

        {:ok, body, _} = Plug.Conn.read_body(conn)

        assert(
          body ==
            Jason.encode!([
              %{
                keyword: "Screws",
                language_code: "en",
                location_name: "Chicago, IL,United States",
                se_domain: "google.com"
              }
            ])
        )

        Plug.Conn.resp(
          conn,
          200,
          "{\"version\":\"0.1.20200310\",\"status_code\":20000,\"status_message\":\"Ok.\",\"time\":\"0.0879sec.\",\"cost\":0.00075,\"tasks_count\":1,\"tasks_error\":0,\"tasks\":[{\"id\":\"03101638-9334-0066-0000-44b65a6119fb\",\"status_code\":20100,\"status_message\":\"TaskCreated.\",\"time\":\"0.0040sec.\",\"cost\":0.00075,\"result_count\":0,\"path\":[\"v3\",\"serp\",\"google\",\"organic\",\"task_post\"],\"data\":{\"api\":\"serp\",\"function\":\"task_post\",\"se\":\"google\",\"se_type\":\"organic\",\"keyword\":\"Screws\",\"language_code\":\"en\",\"location_name\":\"Chicago,IL,UnitedStates\",\"se_domain\":\"google.com\",\"device\":\"desktop\",\"os\":\"windows\"},\"result\":null}]}"
        )
      end)

      resp =
        Serp.create_tasks("Screws",
          language_code: "en",
          location_name: "Chicago, IL,United States",
          se_domain: "google.com"
        )

      assert {:ok, arr} = resp

      assert %DataForSeo.Serp.CreatedTask{
               cost: 7.5e-4,
               id: "03101638-9334-0066-0000-44b65a6119fb",
               keyword: "Screws",
               status_code: 20100,
               status_message: "TaskCreated.",
               tag: nil
             } = List.first(arr)
    end
  end

  describe "completed_tasks/0" do
    test "it returns a list of completed tasks ids", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "GET" = conn.method
        assert "/v3/serp/google/organic/tasks_ready" = conn.request_path

        Plug.Conn.resp(
          conn,
          200,
          "{\"version\":\"0.1.20200310\",\"status_code\":20000,\"status_message\":\"Ok.\",\"time\":\"0.0835sec.\",\"cost\":0,\"tasks_count\":1,\"tasks_error\":0,\"tasks\":[{\"id\":\"03101719-9334-0087-0000-fea493a70e72\",\"status_code\":20000,\"status_message\":\"Ok.\",\"time\":\"0.0555sec.\",\"cost\":0,\"result_count\":2,\"path\":[\"v3\",\"serp\",\"google\",\"organic\",\"tasks_ready\"],\"data\":{\"api\":\"serp\",\"function\":\"tasks_ready\",\"se\":\"google\",\"se_type\":\"organic\"},\"result\":[{\"id\":\"03101628-9334-0066-0000-34ca7793d74a\",\"se\":\"google\",\"se_type\":\"organic\",\"date_posted\":\"2020-03-1014:28:11+00:00\",\"endpoint_regular\":\"\\/v3\\/serp\\/google\\/organic\\/task_get\\/regular\\/03101628-9334-0066-0000-34ca7793d74a\",\"endpoint_advanced\":\"\\/v3\\/serp\\/google\\/organic\\/task_get\\/advanced\\/03101628-9334-0066-0000-34ca7793d74a\",\"endpoint_html\":\"\\/v3\\/serp\\/google\\/organic\\/task_get\\/html\\/03101628-9334-0066-0000-34ca7793d74a\"},{\"id\":\"03101628-9334-0066-0000-df28eb43dfd2\",\"se\":\"google\",\"se_type\":\"organic\",\"date_posted\":\"2020-03-1014:28:11+00:00\",\"endpoint_regular\":\"\\/v3\\/serp\\/google\\/organic\\/task_get\\/regular\\/03101628-9334-0066-0000-df28eb43dfd2\",\"endpoint_advanced\":\"\\/v3\\/serp\\/google\\/organic\\/task_get\\/advanced\\/03101628-9334-0066-0000-df28eb43dfd2\",\"endpoint_html\":\"\\/v3\\/serp\\/google\\/organic\\/task_get\\/html\\/03101628-9334-0066-0000-df28eb43dfd2\"}]}]}"
        )
      end)

      resp = Serp.completed_tasks()

      assert {:ok, arr} = resp

      assert Enum.member?(arr, "03101628-9334-0066-0000-34ca7793d74a")
      assert Enum.member?(arr, "03101628-9334-0066-0000-df28eb43dfd2")
    end
  end

  describe "task_result/1" do
    test "it returns a search result for the task", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "GET" = conn.method

        assert "/v3/serp/google/organic/task_get/regular/03101638-9334-0066-0000-44b65a6119fb" =
                 conn.request_path

        Plug.Conn.resp(
          conn,
          200,
          "{\"version\":\"0.1.20200310\",\"status_code\":20000,\"status_message\":\"Ok.\",\"time\":\"0.1913sec.\",\"cost\":0,\"tasks_count\":1,\"tasks_error\":0,\"tasks\":[{\"id\":\"03101638-9334-0066-0000-44b65a6119fb\",\"status_code\":20000,\"status_message\":\"Ok.\",\"time\":\"0.1010sec.\",\"cost\":0,\"result_count\":1,\"path\":[\"v3\",\"serp\",\"google\",\"organic\",\"task_get\",\"regular\",\"03101638-9334-0066-0000-44b65a6119fb\"],\"data\":{\"api\":\"serp\",\"function\":\"task_get\",\"se\":\"google\",\"se_type\":\"organic\",\"keyword\":\"Screws\",\"language_code\":\"en\",\"location_name\":\"Chicago,IL,UnitedStates\",\"se_domain\":\"google.com\",\"device\":\"desktop\",\"os\":\"windows\"},\"result\":[{\"keyword\":\"Screws\",\"type\":\"organic\",\"se_domain\":\"google.com\",\"location_code\":200602,\"language_code\":\"en\",\"check_url\":\"https:\/\/www.google.com\/search?q=Screws&num=100&hl=en&gl=US&gws_rd=cr&ie=UTF-8&oe=UTF-8&uule=w+CAIQIFISCe3L9NA8LA6IEQDAwAmtpuCv\",\"datetime\":\"2020-03-1014:39:42+00:00\",\"spell\":null,\"item_types\":[\"video\",\"organic\",\"people_also_ask\",\"images\",\"local_pack\",\"paid\",\"related_searches\"],\"se_results_count\":754000000,\"items_count\":99,\"items\":[{\"type\":\"paid\",\"rank_group\":1,\"rank_absolute\":1,\"domain\":\"www.fastenersuperstore.com\",\"title\":\"BuyBulkScrewsOnline|FastenerBuyingMadeSimple‎\",\"description\":\"AllTypes\/Styles\/Heads\/Drives\/Etc.BuyBulk&Save.OrdersShipToday.AllPricingOnline.QuickShipping.34,000+UniqueParts.Types:ConcreteScrews,DeckScrews,DrywallScrews,LagScrews,MachineScrews,MetricScrews,SelfDrillingScrews,WeldScrews.\",\"url\":\"https:\/\/www.fastenersuperstore.com\/category\/screws\",\"breadcrumb\":\"www.fastenersuperstore.com\/Screws\"},{\"type\":\"organic\",\"rank_group\":1,\"rank_absolute\":6,\"domain\":\"www.homedepot.com\",\"title\":\"Screws-Fasteners-TheHomeDepot\",\"description\":\"Getfree2-dayshippingonqualifiedScrewsproductsorbuyHardwaredepartmentproductstodaywithBuyOnlinePickUpinStore.\",\"url\":\"https:\/\/www.homedepot.com\/b\/Hardware-Fasteners-Screws\/N-5yc1vZc2b0\",\"breadcrumb\":\"https:\/\/www.homedepot.com›Hardware-Fasteners-Screws\"}]}]}]}"
        )
      end)

      resp = Serp.task_result("03101638-9334-0066-0000-44b65a6119fb")

      assert {:ok,
              %DataForSeo.Serp.TaskResult{
                check_url:
                  "https://www.google.com/search?q=Screws&num=100&hl=en&gl=US&gws_rd=cr&ie=UTF-8&oe=UTF-8&uule=w+CAIQIFISCe3L9NA8LA6IEQDAwAmtpuCv",
                cost: 0,
                id: "03101638-9334-0066-0000-44b65a6119fb",
                items_count: 99,
                keyword: "Screws",
                language_code: "en",
                location_name: "Chicago,IL,UnitedStates",
                results: [
                  %{
                    breadcrumb: "www.fastenersuperstore.com/Screws",
                    description:
                      "AllTypes/Styles/Heads/Drives/Etc.BuyBulk&Save.OrdersShipToday.AllPricingOnline.QuickShipping.34,000+UniqueParts.Types:ConcreteScrews,DeckScrews,DrywallScrews,LagScrews,MachineScrews,MetricScrews,SelfDrillingScrews,WeldScrews.",
                    domain: "www.fastenersuperstore.com",
                    rank_absolute: 1,
                    rank_group: 1,
                    title: "BuyBulkScrewsOnline|FastenerBuyingMadeSimple‎",
                    type: "paid",
                    url: "https://www.fastenersuperstore.com/category/screws"
                  },
                  %{
                    breadcrumb: "https://www.homedepot.com›Hardware-Fasteners-Screws",
                    description:
                      "Getfree2-dayshippingonqualifiedScrewsproductsorbuyHardwaredepartmentproductstodaywithBuyOnlinePickUpinStore.",
                    domain: "www.homedepot.com",
                    rank_absolute: 6,
                    rank_group: 1,
                    title: "Screws-Fasteners-TheHomeDepot",
                    type: "organic",
                    url: "https://www.homedepot.com/b/Hardware-Fasteners-Screws/N-5yc1vZc2b0"
                  }
                ],
                se_domain: "google.com",
                se_results_count: 754_000_000,
                status_code: 20000,
                status_message: "Ok.",
                tag: nil
              }} = resp
    end
  end
end
