defmodule DataForSeo.DataModel.SERP.TaskReadyItem do
  use DataForSeo.DataModel.Entity
  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:se, :string)
    field(:se_type, :string)

    field(:date_posted, :utc_datetime)
    field(:endpoint_regular, :string)
    field(:endpoint_advanced, :string)
    field(:endpoint_html, :string)
  end

  @fields ~w(
      id
      se
      se_type
      date_posted
      endpoint_regular
      endpoint_advanced
      endpoint_html
      )a
  def changeset(:load, data) do
    data = parse_utc_datetime_at_field(data, "date_posted")
    cast(%__MODULE__{}, data, @fields)
  end
end
