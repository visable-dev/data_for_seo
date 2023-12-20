defmodule DataForSeo.DataModel.Keywords.GoogleTrends.DataQuery do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.Keywords.GoogleTrends.DataQueryNode
  @primary_key false
  embedded_schema do
    embeds_many(:top, DataQueryNode)
    embeds_many(:rising, DataQueryNode)
  end

  @fields ~w(
      )a
  def changeset(%__MODULE__{} = item, data) do
    item
    |> cast(data, @fields)
    |> cast_embed(:top)
    |> cast_embed(:rising)
  end
end
