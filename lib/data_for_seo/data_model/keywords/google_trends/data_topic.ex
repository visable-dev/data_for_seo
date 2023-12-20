defmodule DataForSeo.DataModel.Keywords.GoogleTrends.DataTopic do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.Keywords.GoogleTrends.DataTopicNode
  @primary_key false
  embedded_schema do
    embeds_many(:top, DataTopicNode)
    embeds_many(:rising, DataTopicNode)
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
