defmodule DataForSeo.Serp.PostTaskResponse do
  @moduledoc """
  PostTaskResponse object.
  ## Reference
  https://docs.dataforseo.com/v2/srp#setting-serp-tasks
  """

  defstruct [:status, :error, :results_time, :results_count, :results]
  @type t :: %__MODULE__{}
end
