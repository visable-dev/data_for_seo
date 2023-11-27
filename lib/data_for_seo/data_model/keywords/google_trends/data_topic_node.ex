defmodule DataForSeo.DataModel.Keywords.GoogleTrends.DataTopicNode do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:topic_id, :string)
    field(:topic_title, :string)
    field(:topic_type, :string)
    field(:value, :integer)
  end

  @fields ~w(
      topic_id
      topic_title
      topic_type
      value
      )a
  def changeset(%__MODULE__{} = item, data) do
    cast(item, data, @fields)
  end
end
