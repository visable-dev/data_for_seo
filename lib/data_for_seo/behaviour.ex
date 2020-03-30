defmodule DataForSeo.Behaviour do
  @moduledoc """
  A definition of the intended behavior of the core functions.
  """

  alias DataForSeo.Serp.Response, as: BaseResponse
  alias DataForSeo.Serp.GetTask.Response, as: GetTaskResponse

  @callback configure(Keyword.t()) :: :ok
  @callback configure(:global | :process, Keyword.t()) :: :ok
  @callback configure() :: Keyword.t() | nil

  @callback task_post(String.t() | list(String.t()) | map(), Keyword.t()) ::
              {:ok, BaseResponse.t()} | {:error, String.t()}
  @callback tasks_ready() :: {:ok, BaseResponse.t()} | {:error, String.t()}
  @callback task_get(String.t(), atom()) :: {:ok, GetTaskResponse.t()} | {:error, String.t()}
end
