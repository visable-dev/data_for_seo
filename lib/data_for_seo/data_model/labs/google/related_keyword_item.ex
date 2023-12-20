defmodule DataForSeo.DataModel.Labs.Google.RelatedKeywordItem do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.Labs.Google.KeywordData
  @primary_key false
  embedded_schema do
    field(:se_type, :string)
    embeds_one(:keyword_data, KeywordData)
    field(:depth, :integer)
    field(:related_keywords, {:array, :string})
  end

  @fields ~w(
      se_type
      depth
      related_keywords

      )a

  def changeset(struct, data) do
    struct
    |> cast(data, @fields)
    |> cast_embed(:keyword_data)
  end
end
