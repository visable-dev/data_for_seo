defmodule DataForSeo.DataModel.Labs.Google.KeywordDifficulty do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:se_type, :string)
    field(:keyword, :string)
    field(:keyword_difficulty, :integer)
  end

  @fields ~w(
      se_type
      keyword
      keyword_difficulty
      )a

  def changeset(struct, data) do
    cast(struct, data, @fields)
  end
end
