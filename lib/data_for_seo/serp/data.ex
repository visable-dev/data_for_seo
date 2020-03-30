defmodule DataForSeo.Serp.Data do
  @moduledoc """
  Дата struct.
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/task_post/
  """

  @type t :: %__MODULE__{
          api: String.t(),
          function: String.t(),
          se: String.t(),
          se_type: String.t(),
          language_name: String.t() | nil,
          location_name: String.t() | nil,
          keyword: String.t() | nil,
          priority: integer() | String.t() | nil,
          tag: String.t() | nil,
          device: String.t() | nil,
          os: String.t() | nil
        }

  defstruct [
    :api,
    :function,
    :se,
    :se_type,
    :language_name,
    :location_name,
    :keyword,
    :priority,
    :tag,
    :device,
    :os
  ]
end
