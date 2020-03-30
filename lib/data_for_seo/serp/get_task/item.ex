defmodule DataForSeo.Serp.GetTask.Item do
  @moduledoc """
  GetTask.Item struct.
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/task_get/regular/
  """

  @type t :: %__MODULE__{
          type: String.t(),
          rank_group: integer(),
          rank_absolute: integer(),
          domain: String.t(),
          title: String.t(),
          description: String.t(),
          url: String.t(),
          breadcrumb: String.t()
        }

  defstruct [:type, :rank_group, :rank_absolute, :domain, :title, :description, :url, :breadcrumb]
end
