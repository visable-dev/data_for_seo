defmodule DataForSeo.DataModel.Entity do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      @type t :: %__MODULE__{}

      defp parse_utc_datetime_at_field(map, fields) when is_list(fields) do
        Enum.reduce(fields, map, &parse_utc_datetime_at_field(&2, &1))
      end

      defp parse_utc_datetime_at_field(map, field) when is_binary(field) do
        case Map.get(map, field) do
          str when is_binary(str) -> Map.put(map, field, convert_utc_datetime(str))
          _ -> map
        end
      end

      defp convert_utc_datetime(nil), do: nil

      defp convert_utc_datetime(dt) when is_binary(dt) do
        # May be it's alread ISO format?
        case DateTime.from_iso8601(dt) do
          {:ok, parsed, _offset} -> parsed
          {:error, _} -> Timex.parse!(dt, "%F %T %:z", :strftime)
        end
      end
    end
  end
end
