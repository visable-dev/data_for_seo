defmodule DataForSeo.DataModel.Labs.Google.KeywordImpressionsInfo do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:se_type, :string)
    field(:last_updated_time, :utc_datetime)
    field(:match_type, :string)
    field(:bid, :float)

    field(:ad_position_min, :float)
    field(:ad_position_max, :float)
    field(:ad_position_average, :float)
    field(:cpc_min, :float)
    field(:cpc_max, :float)
    field(:cpc_average, :float)

    field(:daily_impressions_min, :float)
    field(:daily_impressions_max, :float)
    field(:daily_impressions_average, :float)
    field(:daily_clicks_min, :float)
    field(:daily_clicks_max, :float)
    field(:daily_clicks_average, :float)
    field(:daily_cost_min, :float)
    field(:daily_cost_max, :float)
    field(:daily_cost_average, :float)
  end

  @fields ~w(
      se_type
      match_type
      bid
      ad_position_min
      ad_position_max
      ad_position_average
      cpc_min
      cpc_max
      cpc_average
      daily_impressions_min
      daily_impressions_max
      daily_impressions_average
      daily_clicks_min
      daily_clicks_max
      daily_clicks_average
      daily_cost_min
      daily_cost_max
      daily_cost_average
      last_updated_time
      )a

  def changeset(struct, data) do
    data = parse_utc_datetime_at_field(data, "last_updated_time")
    cast(struct, data, @fields)
  end
end
