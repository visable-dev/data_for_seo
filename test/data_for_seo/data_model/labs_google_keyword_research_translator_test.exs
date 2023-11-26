defmodule DataForSeo.DataModel.LabsGooogleKeywordResearchTranslatorTest do
  use ExUnit.Case
  use DataForSeo.TranslatorCase

  alias DataForSeo.DataModel.Labs.Google.SearchIntentResult
  alias DataForSeo.DataModel.Labs.Google.SearchIntentItem
  alias DataForSeo.DataModel.Labs.Google.SearchIntentForKeyword

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
  end
end
