defmodule DataForSeo.Behaviour do
  @moduledoc """
  A definition of the intended behavior of the core functions.
  """

  alias DataForSeo.Serp.{CreateTasksResponse, CompletedTasksResponse, TaskResultResponse}

  @callback configure(Keyword.t()) :: :ok
  @callback configure(:global | :process, Keyword.t()) :: :ok
  @callback configure() :: Keyword.t() | nil
  @callback request(:get | :post, String.t()) :: map()
  @callback request(:get | :post, String.t(), Keyword.t()) :: map()

  @callback create_tasks(map(), Keyword.t()) ::  {:ok, CreateTasksResponse.t()} | {:error, String.t()}
  @callback completed_tasks :: {:ok, CompletedTasksResponse.t()} | {:error, String.t()}
  @callback task_result(integer()) :: {:ok, TaskResultResponse.t()} | {:error, String.t()}
end
