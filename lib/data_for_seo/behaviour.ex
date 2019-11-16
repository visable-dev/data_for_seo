defmodule DataForSeo.Behaviour do
  @moduledoc """
  A definition of the intended behavior of the core functions.
  """

  @callback configure(Keyword.t()) :: :ok
  @callback configure(:global | :process, Keyword.t()) :: :ok
  @callback configure() :: Keyword.t() | nil
end
