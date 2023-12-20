defmodule DataForSeo.DataModel.Labs.Google.SearchIntentResult do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.Labs.Google.SearchIntentForKeyword
  @primary_key false
  embedded_schema do
    field(:language_code, :string)
    field(:items_count, :integer)

    embeds_many(:items, SearchIntentForKeyword)
  end

  @fields ~w(
      language_code
      items_count
      )a

  def changeset(:load, data) do
    %__MODULE__{}
    |> cast(data, @fields)
    |> cast_embed(:items)
  end
end
