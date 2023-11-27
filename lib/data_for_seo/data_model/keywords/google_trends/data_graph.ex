defmodule DataForSeo.DataModel.Keywords.GoogleTrends.DataGraph do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:date_from, :date)
    field(:date_to, :date)
    field(:timestamp, :integer)
    field(:missing_data, :boolean)
    field(:values, {:array, :integer})
  end

  @fields ~w(
      date_from
      date_to
      timestamp
      missing_data
      values
      )a
  def changeset(%__MODULE__{} = item, data) do
    cast(item, data, @fields)
  end
end
