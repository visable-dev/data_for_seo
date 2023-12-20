defmodule DataForSeo.DataModel.Keywords.GoogleTrends.ExplorerItem do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.Keywords.GoogleTrends.DataGraph
  alias DataForSeo.DataModel.Keywords.GoogleTrends.DataMap
  alias DataForSeo.DataModel.Keywords.GoogleTrends.DataQuery
  alias DataForSeo.DataModel.Keywords.GoogleTrends.DataTopic
  @primary_key false
  embedded_schema do
    field(:type, :string)
    field(:position, :integer)
    field(:title, :string)
    field(:keywords, {:array, :string})
    field(:averages, {:array, :integer})
    embeds_many(:graphs, DataGraph)
    embeds_many(:maps, DataMap)
    embeds_one(:queries_list, DataQuery)
    embeds_one(:topics_list, DataTopic)
  end

  @fields ~w(
      type
      position
      title
      keywords
      averages
      )a
  def changeset(%__MODULE__{} = item, data) do
    data = split_embedded_data(data)

    item
    |> cast(data, @fields)
    |> cast_embed(:graphs)
    |> cast_embed(:maps)
    |> cast_embed(:queries_list)
    |> cast_embed(:topics_list)
  end

  @split_config %{
    "google_trends_graph" => "graphs",
    "google_trends_map" => "maps",
    "google_trends_queries_list" => "queries_list",
    "google_trends_topics_list" => "topics_list"
  }
  defp split_embedded_data(data) do
    Map.put(data, @split_config[data["type"]], data["data"])
  end

  # assert length(grouped["google_trends_graph"]) == 1
  #      assert length(grouped["google_trends_map"]) == 3
  #      assert length(grouped["google_trends_queries_list"]) == 2
end
