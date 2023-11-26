defmodule DataForSeo.DataModel.GoogleSerpTranslatorTest do
  use ExUnit.Case
  use DataForSeo.TranslatorCase

  alias DataForSeo.DataModel.SERP.TaskReadyItem
  alias DataForSeo.DataModel.SERP.Google.SerpItemRegular

  describe "serp/google/organic" do
    test "task-post" do
      assert %Task{result: nil} =
               translate_task_from_fixture(["serp", "google", "organic", "task-post"])
    end

    test "task-get-regular" do
      assert %Task{result: result} =
               translate_task_from_fixture(["serp", "google", "organic", "task-get-regular"])

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

      assert %SerpItemRegular{
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

    test "tasks-ready" do
      %Task{result: tasks} =
        translate_task_from_fixture(["serp", "google", "organic", "tasks-ready"])

      assert length(tasks) == 2
      ids = ["11081554-0696-0066-0000-27e68ec15871", "11151406-0696-0066-0000-c4ece317cdb2"]

      Enum.each(tasks, fn %TaskReadyItem{id: id} ->
        assert Enum.member?(ids, id)
      end)
    end
  end
end
