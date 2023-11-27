defmodule DataForSeo.DataModel.Labs.Google.SearchIntentItem do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:label, :string)
    field(:probability, :float)
  end

  @fields ~w(
      label
      probability
      )a

  def changeset(struct, data) do
    cast(struct, data, @fields)
  end
end
