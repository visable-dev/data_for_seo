defmodule DataForSeo.DataModel.Generic.Task do
  use DataForSeo.DataModel.Entity
  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:status_code, :integer)
    field(:status_message, :string)

    field(:time, :string)
    field(:cost, :float)
    field(:result_count, :integer)
    field(:path, {:array, :string})
    field(:data, :map)
    field(:result, {:array, :map})
  end

  @fields ~w(
      id
      status_code
      status_message
      time
      cost
      result_count
      path
      data
      result
      )a
  def changeset(struct, data) do
    struct
    |> cast(data, @fields)
  end
end
