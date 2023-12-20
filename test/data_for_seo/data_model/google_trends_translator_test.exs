defmodule DataForSeo.DataModel.GoogleTrendsTranslatorTest do
  use ExUnit.Case
  use DataForSeo.TranslatorCase

  alias DataForSeo.DataModel.Keywords.GoogleTrends.Explorer.TaskReadyItem
  alias DataForSeo.DataModel.Keywords.GoogleTrends.ExplorerResult
  alias alias DataForSeo.DataModel.Keywords.GoogleTrends.ExplorerItem
  alias DataForSeo.DataModel.Keywords.GoogleTrends.DataGraph
  alias DataForSeo.DataModel.Keywords.GoogleTrends.DataMap
  alias DataForSeo.DataModel.Keywords.GoogleTrends.DataQuery
  alias DataForSeo.DataModel.Keywords.GoogleTrends.DataQueryNode
  alias DataForSeo.DataModel.Keywords.GoogleTrends.DataTopic
  alias DataForSeo.DataModel.Keywords.GoogleTrends.DataTopicNode
  alias alias DataForSeo.DataModel.Category
  alias alias DataForSeo.DataModel.Language
  alias alias DataForSeo.DataModel.Location

  describe "keywords/google_trends/explorer" do
    test "task-post" do
      assert %Task{id: "02122119-1535-0170-0000-0228cf083d8e", result: nil} =
               translate_task_from_fixture(["keywords", "google_trends", "explorer", "task-post"])
    end

    test "task-get" do
      assert %Task{result: result} =
               translate_task_from_fixture(["keywords", "google_trends", "explorer", "task-get"])

      assert [
               %ExplorerResult{
                 keywords: [
                   "seo api",
                   "rank api"
                 ],
                 type: "trends",
                 location_code: 0,
                 language_code: "en",
                 check_url:
                   "https://trends.google.com/trends/explore?hl=en&date=2019-01-01%202020-01-01&q=seo%20api%2Crank%20api",
                 datetime: ~U[2022-04-21 18:22:05Z],
                 items_count: 6,
                 items: items
               }
             ] = result

      assert length(items) == 6

      grouped = Enum.group_by(items, & &1.type)
      assert length(grouped["google_trends_graph"]) == 1
      assert length(grouped["google_trends_map"]) == 3
      assert length(grouped["google_trends_queries_list"]) == 2

      assert %ExplorerItem{
               type: "google_trends_graph",
               graphs: graphs,
               title: "Interest over time",
               keywords: [
                 "seo api",
                 "rank api"
               ],
               averages: [
                 62,
                 46
               ]
             } = hd(grouped["google_trends_graph"])

      assert %DataGraph{
               date_from: ~D[2019-01-06],
               date_to: ~D[2019-01-12],
               timestamp: 1_546_732_800,
               missing_data: false,
               values: [
                 62,
                 37
               ]
             } == hd(graphs)

      assert %ExplorerItem{
               type: "google_trends_map",
               maps: maps,
               title: "Compared breakdown by region",
               keywords: [
                 "seo api",
                 "rank api"
               ]
             } = hd(grouped["google_trends_map"])

      assert %DataMap{
               geo_id: "LA",
               geo_name: "Laos",
               values: [
                 nil,
                 100
               ],
               max_value_index: 1
             } == hd(maps)

      assert %ExplorerItem{
               position: 4,
               type: "google_trends_queries_list",
               title: "Related queries",
               keywords: [
                 "seo api"
               ],
               queries_list: %DataQuery{
                 top: top_queries,
                 rising: rising_queries
               }
             } = hd(grouped["google_trends_queries_list"])

      assert %DataQueryNode{
               query: "google seo api",
               value: 100
             } == hd(top_queries)

      assert %DataQueryNode{
               query: "api for seo software projects",
               value: 120
             } == hd(rising_queries)
    end

    test "task-live" do
      assert %Task{result: result} =
               translate_task_from_fixture(["keywords", "google_trends", "explorer", "task-live"])

      assert [
               %ExplorerResult{
                 keywords: [
                   "seo api"
                 ],
                 type: "trends",
                 location_code: 2840,
                 language_code: "en",
                 check_url:
                   "https://trends.google.com/trends/explore?hl=en&geo=US&date=2019-01-01%202020-01-01&q=seo%20api",
                 datetime: ~U[2022-04-21 18:40:17Z],
                 items_count: 4,
                 items: items
               }
             ] = result

      assert length(items) == 4

      grouped = Enum.group_by(items, & &1.type)
      assert length(grouped["google_trends_graph"]) == 1
      assert length(grouped["google_trends_map"]) == 1
      assert length(grouped["google_trends_queries_list"]) == 1
      assert length(grouped["google_trends_topics_list"]) == 1

      # It's the same as task-get, test only topics_list here b/c it wasn't included in task-get fixture
      assert %ExplorerItem{
               position: 3,
               type: "google_trends_topics_list",
               title: "Related topics",
               keywords: [
                 "seo api"
               ],
               topics_list: %DataTopic{
                 top: top_topics,
                 rising: rising_topics
               }
             } = hd(grouped["google_trends_topics_list"])

      assert %DataTopicNode{
               topic_id: "/m/019qb_",
               topic_title: "Search Engine Optimization",
               topic_type: "Topic",
               value: 100
             } == hd(top_topics)

      assert %DataTopicNode{
               topic_id: "/m/086df",
               topic_title: "Web design",
               topic_type: "Discipline",
               value: 400
             } == hd(rising_topics)
    end

    test "tasks-ready" do
      %Task{result: tasks} =
        translate_task_from_fixture(["keywords", "google_trends", "explorer", "tasks-ready"])

      assert length(tasks) == 3

      ids = [
        "10311535-0696-0093-0000-8fe3770f079b",
        "11111403-0696-0110-0000-c69794ecf661",
        "11201044-0696-0110-0000-9f560a19543e"
      ]

      Enum.each(tasks, fn %TaskReadyItem{id: id} ->
        assert Enum.member?(ids, id)
      end)
    end
  end

  describe "categories/languages/locations" do
    test "categories" do
      assert %Task{
               result: items
             } = translate_task_from_fixture(["keywords", "google_trends", "categories"])

      assert 4 == length(items)

      [
        %Category{category_code: 10021, category_code_parent: nil, category_name: "Apparel"},
        %Category{
          category_code: 10178,
          category_code_parent: 10021,
          category_name: "Apparel Accessories"
        }
        | _
      ] = items
    end

    test "locations" do
      assert %Task{
               result: items
             } = translate_task_from_fixture(["keywords", "google_trends", "locations"])

      assert 8 == length(items)

      [
        %Location{
          location_code: 2004,
          location_name: "Afghanistan",
          location_code_parent: nil,
          country_iso_code: "AF",
          location_type: "Country",
          geo_name: "Afghanistan",
          geo_id: "AF"
        }
        | _
      ] = items
    end

    test "languages" do
      assert %Task{
               result: items
             } = translate_task_from_fixture(["keywords", "google_trends", "languages"])

      assert 4 == length(items)

      [
        %Language{
          language_name: "Afrikaans",
          language_code: "af"
        }
        | _
      ] = items
    end
  end
end
