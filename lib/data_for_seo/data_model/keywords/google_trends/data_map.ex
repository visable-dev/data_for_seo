defmodule DataForSeo.DataModel.Keywords.GoogleTrends.DataMap do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:geo_id, :string)
    field(:geo_name, :string)
    field(:max_value_index, :integer)
    field(:values, {:array, :integer})
  end

  @fields ~w(
      geo_id
      geo_name
      max_value_index
      values
      )a
  def changeset(%__MODULE__{} = item, data) do
    cast(item, data, @fields)
  end
end
