defmodule DataForSeo.DataModel.ResponseTranslatorTest do
  use ExUnit.Case

  alias DataForSeo.DataModel.Transform.ResponseTranslator
  alias DataForSeo.DataModel.Generic.Response
  alias DataForSeo.DataModel.Generic.Task
  alias DataForSeo.DataModel.SERP.TaskReadyItem
  alias DataForSeo.DataModel.SERP.Google.SerpItemRegular, as: GoogleSerpItemRegular
  import DataForSeo.Test.ResponseFactory

  test "test translating response into object" do
    # Get all available fixtures and check if they could be loaded into response struct
    :data_for_seo
    |> :code.priv_dir()
    |> Path.join("/**/*.json")
    |> Path.wildcard()
    |> Enum.each(fn f ->
      json = get_json_fixture(f)
      r = %Response{} = ResponseTranslator.load_response(json)
      assert r.cost == json["cost"]
      assert r.status_code == json["status_code"]
      assert r.status_message == json["status_message"]

      assert length(r.tasks) == length(json["tasks"])
      assert %Task{} = hd(r.tasks)
    end)
  end

  describe "load_task_result/1" do
    test "serp/google/organic/task-post" do
      assert %Task{result: nil} =
               ["serp", "google", "organic", "task-post"]
               |> get_json_fixture()
               |> ResponseTranslator.load_response()
               |> ResponseTranslator.get_tasks()
               |> hd()
               |> ResponseTranslator.load_task_result()
    end

    test "serp/google/organic/task-get" do
      assert %Task{result: result} =
               ["serp", "google", "organic", "task-get-regular"]
               |> get_json_fixture()
               |> ResponseTranslator.load_response()
               |> ResponseTranslator.get_tasks()
               |> hd()
               |> ResponseTranslator.load_task_result()

      assert [
               %{
                 datetime: ~U[2019-11-15 12:57:46Z],
                 item_types: ["organic", "paid"],
                 items_count: 96,
                 keyword: "flight ticket new york san francisco",
                 language_code: "en",
                 location_code: 2840,
                 regular_items: items,
                 se_domain: "google.com",
                 se_results_count: 85_600_000,
                 spell: nil,
                 type: "organic"
               }
             ] = result

      assert length(items) == 9

      assert %GoogleSerpItemRegular{
               breadcrumb: "www.bookingbuddy.com/Flights",
               description:
                 "Compare Airlines & Sites. Cheap Flights on BookingBuddy, a TripAdvisor Company",
               domain: "www.bookingbuddy.com",
               rank_absolute: 1,
               rank_group: 1,
               title: "Flights To Lwo | Unbelievably Cheap Flights | BookingBuddy.com‎",
               type: "paid",
               url: "https://www.bookingbuddy.com/en/hero/"
             } == hd(items)
    end

    test "serp/google/organic/tasks-ready" do
      %Task{result: tasks} =
        ["serp", "google", "organic", "tasks-ready"]
        |> get_json_fixture()
        |> ResponseTranslator.load_response()
        |> ResponseTranslator.get_tasks()
        |> hd()
        |> ResponseTranslator.load_task_result()

      assert length(tasks) == 2
      ids = ["11081554-0696-0066-0000-27e68ec15871", "11151406-0696-0066-0000-c4ece317cdb2"]

      Enum.each(tasks, fn %TaskReadyItem{id: id} ->
        assert Enum.member?(ids, id)
      end)
    end
  end
end
