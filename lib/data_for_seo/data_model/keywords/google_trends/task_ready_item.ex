defmodule DataForSeo.DataModel.Keywords.GoogleTrends.Explorer.TaskReadyItem do
  use DataForSeo.DataModel.Entity
  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:se, :string)
    field(:function, :string)

    field(:date_posted, :utc_datetime)
    field(:tag, :string)
    field(:endpoint, :string)
  end

  @fields ~w(
      id
      se
      function
      tag
      date_posted
      endpoint
      )a
  def changeset(:load, data) do
    data = parse_utc_datetime_at_field(data, "date_posted")
    cast(%__MODULE__{}, data, @fields)
  end
end
