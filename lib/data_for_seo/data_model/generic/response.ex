defmodule DataForSeo.DataModel.Generic.Response do
  use DataForSeo.DataModel.Entity
  alias DataForSeo.DataModel.Generic.Task
  @primary_key false
  embedded_schema do
    field(:version, :string)
    field(:status_code, :integer)
    field(:status_message, :string)

    field(:time, :string)
    field(:cost, :float)
    field(:tasks_count, :integer)
    field(:tasks_error, :integer)
    embeds_many(:tasks, Task)
  end

  @fields ~w(
      version
      status_code
      status_message
      time
      cost
      tasks_count
      tasks_error
      )a

  def changeset(:load, data) do
    %__MODULE__{}
    |> cast(data, @fields)
    |> cast_embed(:tasks)
  end
end
