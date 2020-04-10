defmodule DataForSeo.Behaviour do
  @moduledoc """
  A definition of the intended behavior of the core functions.
  """

  alias DataForSeo.Serp.Response, as: BaseResponse
  alias DataForSeo.Serp.GetTask.Response, as: GetTaskResponse

  @callback configure(Keyword.t()) :: :ok
  @callback configure(:global | :process, Keyword.t()) :: :ok
  @callback configure() :: Keyword.t() | nil

  @callback task_post(list(map()) | map()) ::
              {:ok, BaseResponse.t()} | {:error, String.t()}
  @callback tasks_ready() :: {:ok, BaseResponse.t()} | {:error, String.t()}
  @callback task_get(String.t(), list()) ::
              {:ok, GetTaskResponse.t() | map()} | {:error, String.t()}
end
