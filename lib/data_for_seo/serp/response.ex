defmodule DataForSeo.Serp.Response do
  @moduledoc """
  Task struct.
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/task_post/
  """

  alias DataForSeo.Serp.{Task}

  @type t :: %__MODULE__{
          version: String.t(),
          status_code: integer(),
          status_message: String.t(),
          time: String.t(),
          cost: float(),
          tasks_count: integer(),
          tasks_error: integer(),
          tasks: list(Task.t())
        }

  defstruct version: nil,
            status_code: nil,
            status_message: nil,
            time: nil,
            cost: nil,
            tasks_count: nil,
            tasks_error: nil,
            tasks: []
end
