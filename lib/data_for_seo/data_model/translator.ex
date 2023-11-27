defmodule DataForSeo.DataModel.Translator do
  defmacro __using__(_) do
    quote do
      alias Ecto.Changeset
      @type input_result :: map() | [map()] | nil
      @type task_path :: [String.t()]
      defp load_map_into(list_of_maps, module, changeset_type \\ :load)

      defp load_map_into(list_of_maps, module, changeset_type) when is_list(list_of_maps) do
        Enum.map(list_of_maps, &load_map_into(&1, module, changeset_type))
      end

      defp load_map_into(map, module, changeset_type) do
        changeset_type
        |> module.changeset(map)
        |> Changeset.apply_changes()
      end
    end
  end
end
