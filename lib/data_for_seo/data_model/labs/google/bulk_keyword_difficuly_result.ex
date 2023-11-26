defmodule DataForSeo.DataModel.Labs.Google.BulkKeywordDifficultyResult do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.Labs.Google.KeywordDifficulty
  @primary_key false
  embedded_schema do
    field(:se_type, :string)
    field(:location_code, :integer)
    field(:language_code, :string)
    field(:items_count, :integer)
    field(:total_count, :integer)

    embeds_many(:items, KeywordDifficulty)
  end

  @fields ~w(
      se_type
      location_code
      language_code
      items_count
      total_count
      )a

  def changeset(:load, data) do
    %__MODULE__{}
    |> cast(data, @fields)
    |> cast_embed(:items)
  end
end
