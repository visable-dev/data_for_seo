defmodule DataForSeo.Serp.CreatedTask do
  @moduledoc """
  Task object.
  ## Reference
  https://docs.dataforseo.com/v2/srp#setting-serp-tasks
  """

  defstruct [:key_id, :loc_id, :post_id, :post_key, :se_id, :status, :task_id]
  @type t :: %__MODULE__{}

  def build(map_with_string_keys) do
    map_with_atom_keys =
      Map.new(map_with_string_keys, fn {key, value} ->
        {String.to_atom(key), value}
      end)

    struct(__MODULE__, map_with_atom_keys)
  end
end
