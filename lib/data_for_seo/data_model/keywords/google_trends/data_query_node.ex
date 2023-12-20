defmodule DataForSeo.DataModel.Keywords.GoogleTrends.DataQueryNode do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:query, :string)
    field(:value, :integer)
  end

  @fields ~w(
      query
      value
      )a
  def changeset(%__MODULE__{} = item, data) do
    cast(item, data, @fields)
  end
end
