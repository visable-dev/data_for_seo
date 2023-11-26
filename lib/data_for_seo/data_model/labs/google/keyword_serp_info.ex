defmodule DataForSeo.DataModel.Labs.Google.KeywordSerpInfo do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:se_type, :string)
    field(:check_url, :string)
    field(:serp_item_types, {:array, :string})
    field(:se_results_count, :integer)
    field(:last_updated_time, :utc_datetime)
    field(:previous_updated_time, :utc_datetime)
  end

  @fields ~w(
      se_type
      check_url
      serp_item_types
      se_results_count
      last_updated_time
      previous_updated_time
      )a

  def changeset(struct, data) do
    data = parse_utc_datetime_at_field(data, ["last_updated_time", "previous_updated_time"])
    cast(struct, data, @fields)
  end
end
