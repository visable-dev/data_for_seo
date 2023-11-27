defmodule DataForSeo.DataModel.Labs.Google.MonthlySearch do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:year, :integer)
    field(:month, :integer)
    field(:search_volume, :integer)
  end

  @fields ~w(
      year
      month
      search_volume

      )a

  def changeset(struct, data) do
    cast(struct, data, @fields)
  end
end
