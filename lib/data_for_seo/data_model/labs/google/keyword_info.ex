defmodule DataForSeo.DataModel.Labs.Google.KeywordInfo do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.Labs.Google.MonthlySearch
  @primary_key false
  embedded_schema do
    field(:se_type, :string)
    field(:last_updated_time, :utc_datetime)
    field(:competition, :integer)
    field(:competition_level, :string)
    field(:cpc, :float)
    field(:search_volume, :integer)

    field(:low_top_of_page_bid, :float)
    field(:high_top_of_page_bid, :float)
    field(:categories, {:array, :integer})
    embeds_many(:monthly_searches, MonthlySearch)
  end

  @fields ~w(
      se_type
      last_updated_time
      competition
      competition_level
      cpc
      search_volume
      low_top_of_page_bid
      high_top_of_page_bid
      categories

      )a

  def changeset(struct, data) do
    data = parse_utc_datetime_at_field(data, "last_updated_time")

    struct
    |> cast(data, @fields)
    |> cast_embed(:monthly_searches)
  end
end
