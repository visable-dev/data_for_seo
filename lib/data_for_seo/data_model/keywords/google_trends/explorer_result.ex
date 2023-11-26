defmodule DataForSeo.DataModel.Keywords.GoogleTrends.ExplorerResult do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.Keywords.GoogleTrends.ExplorerItem
  @primary_key false
  embedded_schema do
    field(:keywords, {:array, :string})
    field(:type, :string)

    field(:location_code, :integer)
    field(:language_code, :string)

    field(:check_url, :string)
    field(:datetime, :utc_datetime)

    field(:items_count, :integer)

    embeds_many(:items, ExplorerItem)
  end

  @fields ~w(
      keywords
      type

      location_code
      language_code

      check_url
      datetime

      items_count
      )a

  def changeset(:load_regular, data) do
    data =
      data
      |> parse_utc_datetime_at_field("datetime")
      |> Map.put("regular_items", data["items"])

    %__MODULE__{}
    |> cast(data, @fields)
    |> cast_embed(:items)
  end
end
