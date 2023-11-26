defmodule DataForSeo.DataModel.SERP.Google.SerpResult do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.SERP.Google.SerpItemRegular
  @primary_key false
  embedded_schema do
    field(:keyword, :string)
    field(:type, :string)
    field(:se_domain, :string)
    field(:location_code, :integer)

    field(:language_code, :string)
    field(:check_url, :string)
    field(:datetime, :utc_datetime)
    field(:spell, :string)
    field(:item_types, {:array, :string})
    field(:se_results_count, :integer)
    field(:items_count, :integer)

    embeds_many(:regual_items, SerpItemRegular)
  end

  @fields ~w(
      keyword
      type
      se_domain
      location_code
      language_code
      check_url
      datetime
      spell
      item_types
      se_results_count
      items_count
      )a

  def changeset(:load_regular, data) do
    data =
      data
      |> parse_utc_datetime()
      |> Map.put("regual_items", data["items"])

    %__MODULE__{}
    |> cast(data, @fields)
    |> cast_embed(:regual_items)
  end

  defp parse_utc_datetime(map = %{"datetime" => dt}),
    do: Map.put(map, "datetime", convert_utc_datetime(dt))

  defp parse_utc_datetime(map), do: map

  defp convert_utc_datetime(nil), do: nil

  defp convert_utc_datetime(dt) when is_binary(dt) do
    Timex.parse!(dt, "%F %T %:z", :strftime)
  end
end
