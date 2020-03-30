defmodule DataForSeo.Serp.Task do
  @moduledoc """
  Task struct.
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/task_post/
  """

  alias DataForSeo.Serp.{Data, Result}

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
