defmodule DataForSeo.DataModel.Location do
  use DataForSeo.DataModel.Entity
  @primary_key false
  embedded_schema do
    field(:location_code, :integer)
    field(:location_name, :string)
    field(:location_code_parent, :integer)
    field(:country_iso_code, :string)
    field(:location_type, :string)
    field(:geo_name, :string)
    field(:geo_id, :string)
  end

  @fields ~w(
      location_code
      location_name
      location_code_parent
      country_iso_code
      location_type
      geo_name
      geo_id
      )a

  def changeset(:load, data) do
    cast(%__MODULE__{}, data, @fields)
  end
end
