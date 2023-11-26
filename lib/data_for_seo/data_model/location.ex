defmodule DataForSeo.DataModel.Location do
  use DataForSeo.DataModel.Entity
  @primary_key false
  embedded_schema do
    field(:location_code, :integer)
    field(:location_name, :string)
    field(:location_code_parent, :integer)
    field(:country_iso_code, :string)
    field(:location_type, :string)
  end
end
