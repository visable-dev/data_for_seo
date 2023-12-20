defmodule DataForSeo.DataModel.Labs.Google.SearchIntentForKeyword do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.Labs.Google.SearchIntentItem
  @primary_key false
  embedded_schema do
    field(:keyword, :string)
    embeds_one(:keyword_intent, SearchIntentItem)
    embeds_many(:secondary_keyword_intents, SearchIntentItem)
  end

  @fields ~w(
      keyword
      )a

  def changeset(struct, data) do
    struct
    |> cast(data, @fields)
    |> cast_embed(:keyword_intent)
    |> cast_embed(:secondary_keyword_intents)
  end
end
