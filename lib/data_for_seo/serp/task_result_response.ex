defmodule DataForSeo.Serp.TaskResultResponse do
  @moduledoc """
  TaskResultResponse object.
  ## Reference
  https://docs.dataforseo.com/v2/srp#get-serp-results-by-task_id
  """

  defstruct [:status, :error, :results_time, :results_count, :results]
  @type t :: %__MODULE__{}

  def build(map_with_string_keys) do
    map_with_atom_keys =
      Map.new(map_with_string_keys, fn {key, value} ->
        {String.to_atom(key), value}
      end)

    struct(__MODULE__, map_with_atom_keys)
  end
end
