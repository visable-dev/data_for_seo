defmodule DataForSeo.DataModel.Labs.Google.SearchIntentInfo do
  use DataForSeo.DataModel.Entity
  @primary_key false
  embedded_schema do
    field(:se_type, :string)
    field(:main_intent, :string)
    field(:foreign_intent, {:array, :string})
    field(:last_updated_time, :utc_datetime)
  end

  @fields ~w(
      se_type
      main_intent
      foreign_intent
      last_updated_time
      )a

  def changeset(struct, data) do
    data = parse_utc_datetime_at_field(data, "last_updated_time")

    struct
    |> cast(data, @fields)
  end
end
