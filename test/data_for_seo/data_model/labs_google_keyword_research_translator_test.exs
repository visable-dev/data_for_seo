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

  alias DataForSeo.DataModel.Labs.Google.KeywordsIdeasResult
  alias DataForSeo.DataModel.Labs.Google.KeywordsSuggestionsResult
  alias DataForSeo.DataModel.Labs.Google.RelatedKeywordsResult
  alias DataForSeo.DataModel.Labs.Google.RelatedKeywordItem
  alias DataForSeo.DataModel.Labs.Google.BulkKeywordDifficultyResult
  alias DataForSeo.DataModel.Labs.Google.KeywordDifficulty
  alias DataForSeo.DataModel.Category

  describe "labs/google" do
    test "categories" do
      assert %Task{
               result: items
             } = translate_task_from_fixture(["labs", "google", "categories"])

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
  end

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

    test "keyword ideas" do
      assert %Task{
               result: [
                 %KeywordsIdeasResult{
                   items_count: 3,
                   total_count: 2_321_099,
                   language_code: "en",
                   items: items
                 }
               ]
             } =
               translate_task_from_fixture(["labs", "google", "keyword_research", "keyword-ideas"])

      assert length(items) == 3

      %KeywordData{
        search_intent_info: intent,
        avg_backlinks_info: backlinks,
        serp_info: serp_info,
        impressions_info: impressions,
        keyword_properties: keyword_properties,
        keyword_info: keyword_info
      } = Enum.find(items, &(&1.keyword == "telephone in japan"))

      assert %SearchIntentInfo{
               se_type: "google",
               main_intent: "commercial",
               foreign_intent: ["informational", "transactional"],
               last_updated_time: ~U[2023-03-02 18:35:26Z]
             } == intent

      assert %AvgBackLinksInfo{
               se_type: "google",
               backlinks: 29.3,
               dofollow: 14.6,
               referring_pages: 26,
               referring_domains: 17,
               referring_main_domains: 15.4,
               rank: 103.5,
               main_domain_rank: 478.1,
               last_updated_time: ~U[2023-03-15 22:05:52Z]
             } == backlinks

      assert %KeywordSerpInfo{
               se_type: "google",
               check_url:
                 "https://www.google.com/search?q=telephone%20in%20japan&num=100&hl=en&gl=US&gws_rd=cr&ie=UTF-8&oe=UTF-8&uule=w+CAIQIFISCQs2MuSEtepUEUK33kOSuTsc",
               serp_item_types: [
                 "featured_snippet",
                 "people_also_ask",
                 "organic",
                 "images",
                 "people_also_search",
                 "related_searches"
               ],
               se_results_count: 332_000_000,
               last_updated_time: ~U[2023-03-15 22:05:45Z],
               previous_updated_time: ~U[2023-02-09 15:33:06Z]
             } == serp_info

      assert %KeywordImpressionsInfo{
               se_type: "google",
               last_updated_time: ~U[2022-03-26 19:32:21Z],
               bid: 999,
               match_type: "exact",
               ad_position_min: nil,
               ad_position_max: nil,
               ad_position_average: nil,
               cpc_min: nil,
               cpc_max: nil,
               cpc_average: nil,
               daily_impressions_min: nil,
               daily_impressions_max: nil,
               daily_impressions_average: nil,
               daily_clicks_min: nil,
               daily_clicks_max: nil,
               daily_clicks_average: nil,
               daily_cost_min: nil,
               daily_cost_max: nil,
               daily_cost_average: nil
             } == impressions

      assert %KeywordProperties{
               se_type: "google",
               core_keyword: nil,
               synonym_clustering_algorithm: "text_processing",
               keyword_difficulty: 48,
               detected_language: "en",
               is_another_language: false
             } == keyword_properties

      assert %KeywordInfo{
               se_type: "google",
               last_updated_time: ~U[2023-03-21 10:09:17Z],
               competition: 0.07,
               competition_level: "LOW",
               cpc: nil,
               search_volume: 210,
               low_top_of_page_bid: nil,
               high_top_of_page_bid: nil,
               categories: [10007, 10878, 12171],
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

    test "keyword suggestions" do
      assert %Task{
               result: [
                 %KeywordsSuggestionsResult{
                   items_count: 3,
                   total_count: 2_582_247,
                   language_code: "en",
                   seed_keyword: "phone",
                   seed_keyword_data: nil,
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
                 "keyword-suggestions"
               ])

      assert length(items) == 3

      %KeywordData{
        search_intent_info: intent,
        avg_backlinks_info: backlinks,
        serp_info: serp_info,
        impressions_info: impressions,
        keyword_properties: keyword_properties,
        keyword_info: keyword_info
      } = Enum.find(items, &(&1.keyword == "find to my phone"))

      assert %SearchIntentInfo{
               se_type: "google",
               main_intent: "commercial",
               foreign_intent: ["navigational"],
               last_updated_time: ~U[2023-03-02 07:46:22Z]
             } == intent

      assert %AvgBackLinksInfo{
               se_type: "google",
               backlinks: 47525.7,
               dofollow: 26457.9,
               referring_pages: 30839.7,
               referring_domains: 2395,
               referring_main_domains: 1958.1,
               rank: 387.3,
               main_domain_rank: 841.3,
               last_updated_time: ~U[2023-02-06 16:31:22Z]
             } == backlinks

      assert %KeywordSerpInfo{
               se_type: "google",
               check_url:
                 "https://www.google.com/search?q=find%20to%20my%20phone&num=100&hl=en&gl=US&gws_rd=cr&ie=UTF-8&oe=UTF-8&uule=w+CAIQIFISCQs2MuSEtepUEUK33kOSuTsc",
               serp_item_types: [
                 "organic",
                 "people_also_ask",
                 "people_also_search",
                 "related_searches",
                 "knowledge_graph"
               ],
               se_results_count: 10_960_000_000,
               last_updated_time: ~U[2023-02-06 16:30:24Z],
               previous_updated_time: ~U[2022-10-20 13:54:33Z]
             } == serp_info

      assert %KeywordImpressionsInfo{
               se_type: "google",
               last_updated_time: ~U[2022-03-22 08:34:45Z],
               bid: 999,
               match_type: "exact",
               ad_position_min: 1.11,
               ad_position_max: 1,
               ad_position_average: 1.06,
               cpc_min: 68.97,
               cpc_max: 84.3,
               cpc_average: 76.63,
               daily_impressions_min: 0.15,
               daily_impressions_max: 0.18,
               daily_impressions_average: 0.16,
               daily_clicks_min: 0.01,
               daily_clicks_max: 0.02,
               daily_clicks_average: 0.01,
               daily_cost_min: 0.98,
               daily_cost_max: 1.2,
               daily_cost_average: 1.09
             } == impressions

      assert %KeywordProperties{
               se_type: "google",
               core_keyword: "find my phone",
               synonym_clustering_algorithm: "text_processing",
               keyword_difficulty: 100,
               detected_language: "en",
               is_another_language: false
             } == keyword_properties

      assert %KeywordInfo{
               se_type: "google",
               last_updated_time: ~U[2023-03-21 00:31:34Z],
               competition: 0.13,
               competition_level: "LOW",
               cpc: 1.37,
               search_volume: 673_000,
               low_top_of_page_bid: 0.53,
               high_top_of_page_bid: 1.37,
               categories: [10019, 10167, 12153],
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

    test "related keyword " do
      assert %Task{
               result: [
                 %RelatedKeywordsResult{
                   items_count: 3,
                   total_count: 8,
                   language_code: "en",
                   seed_keyword: "phone",
                   seed_keyword_data: nil,
                   items: items
                 }
               ]
             } =
               translate_task_from_fixture([
                 "labs",
                 "google",
                 "keyword_research",
                 "related-keywords"
               ])

      assert length(items) == 3

      %RelatedKeywordItem{
        depth: 0,
        se_type: "google",
        related_keywords: [
          "phone call",
          "phone, samsung",
          "phone number",
          "phone call app",
          "phone app",
          "my phone",
          "phone google",
          "phone meaning"
        ],
        keyword_data: keyword_data
      } = hd(items)

      assert %KeywordData{
               keyword: "phone",
               keyword_info: %KeywordInfo{competition_level: "HIGH"},
               keyword_properties: %KeywordProperties{core_keyword: "phone"},
               impressions_info: %KeywordImpressionsInfo{daily_cost_average: 51907.82},
               serp_info: nil,
               avg_backlinks_info: %AvgBackLinksInfo{last_updated_time: ~U[2023-03-13 07:14:56Z]},
               search_intent_info: %SearchIntentInfo{main_intent: "navigational"}
             } = keyword_data
    end

    test "bulk keyword difficulty " do
      assert %Task{
               result: [
                 %BulkKeywordDifficultyResult{
                   items_count: 3,
                   total_count: 3,
                   language_code: "en",
                   location_code: 2840,
                   items: items
                 }
               ]
             } =
               translate_task_from_fixture([
                 "labs",
                 "google",
                 "keyword_research",
                 "bulk-keyword-difficulty"
               ])

      assert length(items) == 3

      [{"car dealer los angeles", 50}, {"dentist new york", 50}, {"pizza brooklyn", 44}]
      |> Enum.each(fn {k, d} ->
        assert %KeywordDifficulty{se_type: "google", keyword: ^k, keyword_difficulty: ^d} =
                 Enum.find(items, &(&1.keyword == k))
      end)
    end
  end
end
