defmodule DataForSeo.DataModel.SERP.Google.SerpItemRegular do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:type, :string)

    field(:rank_group, :integer)
    field(:rank_absolute, :integer)

    field(:domain, :string)
    field(:url, :string)

    field(:title, :string)
    field(:description, :string)
    field(:breadcrumb, :string)
  end

  @fields ~w(
      type
      rank_group
      rank_absolute
      domain
      url
      title
      description
      breadcrumb

      )a
  def changeset(%__MODULE__{} = item, data) do
    cast(item, data, @fields)
  end
end
