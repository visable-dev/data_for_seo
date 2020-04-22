defmodule DataForSeo.Behaviour do
  @moduledoc """
  A definition of the intended behavior of the core functions.
  """

  @callback configure(Keyword.t()) :: :ok
  @callback configure(:global | :process, Keyword.t()) :: :ok
  @callback configure() :: Keyword.t() | nil

  @callback task_post(list(map()) | map()) ::
              {:ok, map()} | {:error, String.t()}
  @callback tasks_ready() :: {:ok, map()} | {:error, String.t()}
  @callback task_get(String.t(), list()) ::
              {:ok, map()} | {:error, String.t()}
end
