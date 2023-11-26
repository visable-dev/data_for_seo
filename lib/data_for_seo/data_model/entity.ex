defmodule DataForSeo.DataModel.Entity do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      @type t :: %__MODULE__{}
    end
  end
end
