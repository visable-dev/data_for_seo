defmodule DataForSeo.DataModel.Labs.Google.KeywordsSuggestionsResult do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.Labs.Google.KeywordData
  @primary_key false
  embedded_schema do
    field(:se_type, :string)
    field(:seed_keyword, :string)
    embeds_one(:seed_keyword_data, KeywordData)
    field(:location_code, :integer)
    field(:language_code, :string)
    field(:total_count, :integer)
    field(:items_count, :integer)
    field(:offset, :integer)
    field(:offset_token, :string)

    embeds_many(:items, KeywordData)
  end

  @fields ~w(
      se_type
      seed_keyword
      location_code
      language_code
      total_count
      items_count
      offset
      offset_token
      )a

  def changeset(:load, data) do
    %__MODULE__{}
    |> cast(data, @fields)
    |> cast_embed(:items)
    |> cast_embed(:seed_keyword_data)
  end
end