defmodule DataForSeo.DataModel.Category do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:category_code, :integer)
    field(:category_name, :string)
    field(:category_code_parent, :integer)
  end

  @fields ~w(
      category_code
      category_name
      category_code_parent
      )a

  def changeset(:load, data) do
    cast(%__MODULE__{}, data, @fields)
  end
end
