defmodule DataForSeo.Serp.CompletedTasks do
  def build(map_with_string_keys) do
    case map_with_string_keys["status_code"] do
      20000 ->
        {:ok, get_result_ids(map_with_string_keys["tasks"])}

      _ ->
        {:error, {map_with_string_keys["status_code"], map_with_string_keys["status_message"]}}
    end
  end

  defp get_result_ids(results) do
    results
    |> List.first()
    |> Map.fetch!("result")
    |> Enum.map(fn result -> result["id"] end)
  end
end
