defmodule DataForSeo.Serp.GetTask.Task do
  @moduledoc """
  GetTask.Task struct.
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/task_get/regular/
  """

  alias DataForSeo.Serp.Data
  alias DataForSeo.Serp.GetTask.Result

  @type t :: %__MODULE__{
          id: String.t(),
          status_code: integer(),
          status_message: String.t(),
          time: String.t(),
          cost: float(),
          result_count: integer(),
          path: list(),
          data: Data.t(),
          result: list(Result.t()) | nil
        }

  defstruct id: nil,
            status_code: nil,
            status_message: nil,
            time: nil,
            cost: nil,
            result_count: nil,
            path: [],
            data: nil,
            result: []
end
