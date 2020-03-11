defmodule DataForSeo.Serp.TaskResult do
  @moduledoc """
  TaskResultResponse object.
  ## Reference
  https://docs.dataforseo.com/v2/srp#get-serp-results-by-task_id
  """

  defstruct [
    :status_code,
    :status_message,
    :id,
    :cost,
    :keyword,
    :tag,
    :language_code,
    :location_name,
    :se_domain,
    :results,
    :items_count,
    :se_results_count,
    :check_url
  ]

  @type t :: %__MODULE__{}

  def build(data) do
    case data["status_code"] do
      20000 ->
        {:ok, build_task_result(List.first(data["tasks"]))}

      _ ->
        {:error, {data["status_code"], data["status_message"]}}
    end
  end

  defp build_task_result(map_with_string_keys) do
    parsed_data =
      base_data(map_with_string_keys)
      |> Map.merge(results_data(List.first(map_with_string_keys["result"])))
      |> Map.merge(task_data(map_with_string_keys["data"]))

    struct(__MODULE__, parsed_data)
  end

  defp base_data(data) do
    Enum.reduce(["status_code", "status_message", "id", "cost"], %{}, fn key, acc ->
      Map.put(acc, String.to_atom(key), data[key])
    end)
  end

  defp results_data(results) do
    %{
      check_url: results["check_url"],
      items_count: results["items_count"],
      se_results_count: results["se_results_count"],
      results: Enum.map(results["items"], &parsed_item_data/1)
    }
  end

  defp parsed_item_data(item_data) do
    Map.new(item_data, fn {key, value} ->
      {String.to_atom(key), value}
    end)
  end

  defp task_data(data) do
    Enum.reduce(["keyword", "tag", "language_code", "location_name", "se_domain"], %{}, fn key,
                                                                                           acc ->
      Map.put(acc, String.to_atom(key), data[key])
    end)
  end
end
