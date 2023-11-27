defmodule DataForSeo.DataModel.Labs.Google.KeywordProperties do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:se_type, :string)
    field(:core_keyword, :string)
    field(:synonym_clustering_algorithm, :string)
    field(:keyword_difficulty, :integer)
    field(:detected_language, :string)
    field(:is_another_language, :boolean)
  end

  @fields ~w(
      se_type
      core_keyword
      synonym_clustering_algorithm
      keyword_difficulty
      detected_language
      is_another_language
      )a

  def changeset(struct, data) do
    cast(struct, data, @fields)
  end
end
