defmodule DataForSeo.Serp.GetTask.Result do
  @moduledoc """
  GetTask.Result struct.
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/task_get/regular/
  """

  alias DataForSeo.Serp.GetTask.Item

  @type t :: %__MODULE__{
          keyword: String.t(),
          type: String.t(),
          se_domain: String.t(),
          location_code: integer(),
          language_code: String.t(),
          check_url: String.t(),
          datetime: DateTime.t(),
          spell: String.t() | nil,
          item_types: list(String.t()),
          se_results_count: integer(),
          items_count: integer(),
          items: list(Item.t())
        }

  defstruct keyword: nil,
            type: nil,
            se_domain: nil,
            location_code: nil,
            language_code: nil,
            check_url: nil,
            datetime: nil,
            spell: nil,
            item_types: nil,
            se_results_count: nil,
            items_count: nil,
            items: []
end
