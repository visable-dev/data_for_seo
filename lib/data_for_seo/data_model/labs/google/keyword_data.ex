defmodule DataForSeo.DataModel.Labs.Google.KeywordData do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.Labs.Google.KeywordInfo
  alias DataForSeo.DataModel.Labs.Google.KeywordProperties
  alias DataForSeo.DataModel.Labs.Google.KeywordImpressionsInfo
  alias DataForSeo.DataModel.Labs.Google.KeywordSerpInfo
  alias DataForSeo.DataModel.Labs.Google.AvgBackLinksInfo
  alias DataForSeo.DataModel.Labs.Google.SearchIntentInfo
  @primary_key false
  embedded_schema do
    field(:se_type, :string)
    field(:keyword, :string)
    field(:location_code, :integer)
    field(:language_code, :string)
    embeds_one(:keyword_info, KeywordInfo)
    embeds_one(:keyword_properties, KeywordProperties)
    embeds_one(:impressions_info, KeywordImpressionsInfo)
    embeds_one(:serp_info, KeywordSerpInfo)
    embeds_one(:avg_backlinks_info, AvgBackLinksInfo)
    embeds_one(:search_intent_info, SearchIntentInfo)
  end

  @fields ~w(
      se_type
      keyword
      location_code
      language_code
      )a

  def changeset(struct, data) do
    struct
    |> cast(data, @fields)
    |> cast_embed(:keyword_info)
    |> cast_embed(:keyword_properties)
    |> cast_embed(:impressions_info)
    |> cast_embed(:serp_info)
    |> cast_embed(:avg_backlinks_info)
    |> cast_embed(:search_intent_info)
  end
end
