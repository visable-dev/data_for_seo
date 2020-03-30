defmodule DataForSeo.Serp.Result do
  @moduledoc """
  Result struct.
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/tasks_ready/
  """

  @type t :: %__MODULE__{
          id: String.t(),
          se: String.t(),
          se_type: String.t(),
          date_posted: DateTime.t(),
          endpoint_regular: String.t(),
          endpoint_advanced: String.t(),
          endpoint_html: String.t()
        }

  defstruct [
    :id,
    :se,
    :se_type,
    :date_posted,
    :endpoint_regular,
    :endpoint_advanced,
    :endpoint_html
  ]
end
