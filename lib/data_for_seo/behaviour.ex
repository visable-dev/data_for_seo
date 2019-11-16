defmodule DataForSeo.Behaviour do
  @moduledoc """
  A definition of the intended behavior of the core functions.
  """

  @callback configure(Keyword.t()) :: :ok
  @callback configure(:global | :process, Keyword.t()) :: :ok
  @callback configure() :: Keyword.t() | nil
  @callback request(:get | :post, String.t()) :: map()
  @callback request(:get | :post, String.t(), Keyword.t()) :: map()

  @callback create_tasks(map(), String.t(), String.t(), String.t(), Keyword.t()) ::
              DataForSeo.Serp.CreateTasksResponse.t()
  @callback completed_tasks :: DataForSeo.Serp.CompletedTasksResponse.t()
end
