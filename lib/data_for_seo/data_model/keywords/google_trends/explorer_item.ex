defmodule DataForSeo.DataModel.Keywords.GoogleTrends.ExplorerItem do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:type, :string)
    # Different types
    # google_trends_graph
    # google_trends_map
    # google_trends_topics_list
    # google_trends_queries_list
  end

  @fields ~w(
      type


      )a
  def changeset(%__MODULE__{} = item, data) do
    cast(item, data, @fields)
  end
end
