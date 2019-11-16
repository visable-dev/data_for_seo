defmodule DataForSeo.Serp.CompletedTask do
  @moduledoc """
  CompletedTask object.
  ## Reference
  https://docs.dataforseo.com/v2/srp#setting-serp-tasks
  """

  defstruct [
    :task_id,
    :post_id,
    :post_key,
    :se_id,
    :loc_id,
    :key_id,
    :results_count,
    :result_extra,
    :result_spell,
    :result_spell_type,
    :result_se_check_url
  ]

  @type t :: %__MODULE__{}

  def build(map_with_string_keys) do
    map_with_atom_keys =
      Map.new(map_with_string_keys, fn {key, value} ->
        {String.to_atom(key), value}
      end)

    struct(__MODULE__, map_with_atom_keys)
  end
end
