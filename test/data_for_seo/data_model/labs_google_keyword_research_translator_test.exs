defmodule DataForSeo.DataModel.LabsGooogleKeywordResearchTranslatorTest do
  use ExUnit.Case
  use DataForSeo.TranslatorCase

  alias DataForSeo.DataModel.Labs.Google.SearchIntentResult
  alias DataForSeo.DataModel.Labs.Google.SearchIntentItem
  alias DataForSeo.DataModel.Labs.Google.SearchIntentForKeyword

  alias DataForSeo.DataModel.Labs.Google.KeywordsForSiteResult
  alias DataForSeo.DataModel.Labs.Google.KeywordData
  alias DataForSeo.DataModel.Labs.Google.KeywordInfo
  alias DataForSeo.DataModel.Labs.Google.KeywordProperties
  alias DataForSeo.DataModel.Labs.Google.KeywordImpressionsInfo
  alias DataForSeo.DataModel.Labs.Google.KeywordSerpInfo
  alias DataForSeo.DataModel.Labs.Google.AvgBackLinksInfo
  alias DataForSeo.DataModel.Labs.Google.SearchIntentInfo
  alias DataForSeo.DataModel.Labs.Google.MonthlySearch

  describe "labs/google/keywords-research" do
    test "search intent" do
      assert %Task{
               result: [%SearchIntentResult{items_count: 4, language_code: "en", items: items}]
             } =
               translate_task_from_fixture(["labs", "google", "keyword_research", "search-intent"])

      assert length(items) == 4

      %SearchIntentForKeyword{keyword_intent: main, secondary_keyword_intents: secondary} =
        Enum.find(items, &(&1.keyword == "milk"))

      assert %SearchIntentItem{label: "commercial", probability: 0.49751797} = main

      assert [
               %SearchIntentItem{
                 label: "transactional",
                 probability: 0.37083894
               },
               %SearchIntentItem{
                 label: "informational",
                 probability: 0.30781138
               }
             ] = secondary
    end

    test "keywords for site" do
      assert %Task{
               result: [
                 %KeywordsForSiteResult{
                   se_type: "google",
                   target: "apple.com",
                   location_code: 2840,
                   language_code: "en",
                   total_count: 6_883_566,
                   items_count: 3,
                   offset: 0,
                   offset_token: <<"eyJDdXJyZW5"::binary, _::binary>>,
                   items: items
                 }
               ]
             } =
               translate_task_from_fixture([
                 "labs",
                 "google",
                 "keyword_research",
                 "keywords-for-site"
               ])

      assert 3 == length(items)

      %KeywordData{
        search_intent_info: intent,
        avg_backlinks_info: backlinks,
        serp_info: serp_info,
        impressions_info: impressions,
        keyword_properties: keyword_properties,
        keyword_info: keyword_info
      } = Enum.find(items, &(&1.keyword == "you"))

      assert %SearchIntentInfo{
               se_type: "google",
               main_intent: "informational",
               foreign_intent: ["navigational"],
               last_updated_time: ~U[2023-03-03 15:55:21Z]
             } == intent

      assert %AvgBackLinksInfo{
               se_type: "google",
               backlinks: 3962.6,
               dofollow: 2203,
               referring_pages: 2590.4,
               referring_domains: 418.5,
               referring_main_domains: 307.3,
               rank: 180.7,
               main_domain_rank: 930.8,
               last_updated_time: ~U[2023-03-01 09:44:45Z]
             } == backlinks

      assert %KeywordSerpInfo{
               se_type: "google",
               check_url:
                 "https://www.google.com/search?q=you&num=100&hl=en&gl=US&gws_rd=cr&ie=UTF-8&oe=UTF-8&uule=w+CAIQIFISCQs2MuSEtepUEUK33kOSuTsc",
               serp_item_types: [
                 "organic",
                 "video",
                 "twitter",
                 "images",
                 "related_searches",
                 "knowledge_graph"
               ],
               se_results_count: 100,
               last_updated_time: ~U[2023-03-01 09:44:24Z],
               previous_updated_time: ~U[2023-01-26 19:59:58Z]
             } == serp_info

      assert %KeywordImpressionsInfo{
               se_type: "google",
               last_updated_time: ~U[2022-04-17 18:54:48Z],
               bid: 999,
               match_type: "exact",
               ad_position_min: 1.11,
               ad_position_max: 1,
               ad_position_average: 1.06,
               cpc_min: 2.69,
               cpc_max: 3.29,
               cpc_average: 2.99,
               daily_impressions_min: 515.37,
               daily_impressions_max: 629.9,
               daily_impressions_average: 572.63,
               daily_clicks_min: 55.58,
               daily_clicks_max: 67.93,
               daily_clicks_average: 61.75,
               daily_cost_min: 166.29,
               daily_cost_max: 203.25,
               daily_cost_average: 184.77
             } == impressions

      assert %KeywordProperties{
               se_type: "google",
               core_keyword: nil,
               synonym_clustering_algorithm: "text_processing",
               keyword_difficulty: 23,
               detected_language: "en",
               is_another_language: false
             } == keyword_properties

      assert %KeywordInfo{
               se_type: "google",
               last_updated_time: ~U[2023-03-21 07:07:46Z],
               competition: nil,
               competition_level: "LOW",
               cpc: 0.04,
               search_volume: 185_000_000,
               low_top_of_page_bid: 0.01,
               high_top_of_page_bid: 0.04,
               categories: [
                 10013,
                 10109,
                 13546
               ],
               monthly_searches: monthly_searches
             } = keyword_info

      assert length(monthly_searches) == 12

      Enum.each(1..12, fn month ->
        year = if(month in [1, 2], do: 2023, else: 2022)

        assert %MonthlySearch{month: ^month, year: ^year, search_volume: volume} =
                 Enum.find(monthly_searches, &(&1.month == month))

        assert volume > 0
      end)
    end
  end
end
