defmodule DataForSeo.Serp.CreatedTask do
  @moduledoc """
  Task object.
  ## Reference
  https://docs.dataforseo.com/v2/srp#setting-serp-tasks
  """

  defstruct [:cost, :id, :status_code, :status_message, :keyword, :tag]
  @type t :: %__MODULE__{}

  def build(map_with_string_keys) do
    map_with_atom_keys =
      Map.merge(
        Map.new(map_with_string_keys, fn {key, value} ->
          {String.to_atom(key), value}
        end),
        Map.new(map_with_string_keys["data"], fn {key, value} ->
          {String.to_atom(key), value}
        end)
      )

    struct(__MODULE__, map_with_atom_keys)
  end
end
