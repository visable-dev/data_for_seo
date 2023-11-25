defmodule DataForSeo.API.EndpointHandler do
  @moduledoc """
  Basic module with some shared functionality.
  """

  defmacro __using__(_) do
    quote do
      alias DataForSeo.Client
      alias DataForSeo.Parser

      @type generic_response :: {:ok, any()} | {:error, any()}

      defp post_task(endpoint_url, payload) when is_map(payload) do
        # wrap a single task
        post_task(endpoint_url, [payload])
      end

      defp post_task(endpoint_url, payload) when is_list(payload) do
        endpoint_url
        |> Client.post(payload)
        |> Client.validate_status_code()
        |> Client.decode_json_response()
        |> case do
          {:ok, resp} ->
            {:ok, Parser.parse(resp, :task_post)}

          {:error, error} ->
            {:error, error}
        end
      end

      defp get_live_task(endpoint_url, payload) when is_map(payload) do
        # wrap a single task
        get_live_task(endpoint_url, [payload])
      end

      defp get_live_task(endpoint_url, payload) when is_list(payload) do
        endpoint_url
        |> Client.post(payload)
        |> Client.validate_status_code()
        |> Client.decode_json_response()
        |> case do
          {:ok, resp} ->
            {:ok, Parser.parse(resp, :task_result)}

          {:error, error} ->
            {:error, error}
        end
      end

      defp get_ready_tasks(endpoint_url) do
        endpoint_url
        |> Client.get()
        |> Client.validate_status_code()
        |> Client.decode_json_response()
        |> case do
          {:ok, resp} ->
            {:ok, Parser.parse(resp, :tasks_ready)}

          {:error, error} ->
            {:error, error}
        end
      end

      defp get_one_task(endpoint_url) do
        endpoint_url
        |> Client.get()
        |> Client.validate_status_code()
        |> Client.decode_json_response()
        |> case do
          {:ok, resp} ->
            {:ok, Parser.parse(resp, :task_result)}

          {:error, error} ->
            {:error, error}
        end
      end

      defp handle_response(resp), do: resp

      # Apply location to payload from params
      # nil value skip adding
      # otherwise it must be valid numberic location code or any valid location name
      defp apply_location(attrs, nil), do: attrs

      defp apply_location(attrs, loc) do
        # test location, if it's integer - we have location code
        # we support code both: as int and string
        case Integer.parse("#{loc}") do
          :error -> Map.put(attrs, :location_name, loc)
          {code, _} -> Map.put(attrs, :location_code, code)
        end
      end

      # Apply language to payload from params
      # nil value skip adding
      # otherwise it must be 2-char lang code or any valid language name
      defp apply_language(attrs, nil), do: attrs

      defp apply_language(attrs, <<code::binary-size(2), "">>),
        do: Map.put(attrs, :language_code, code)

      defp apply_language(attrs, lang_name), do: Map.put(attrs, :language_name, lang_name)

      defp apply_tag(attrs, nil), do: attrs
      defp apply_tag(attrs, tag = <<_::binary-size(1), _::binary>>), do: Map.put(attrs, :tag, tag)
    end
  end
end
