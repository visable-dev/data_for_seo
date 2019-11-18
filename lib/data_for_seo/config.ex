defmodule DataForSeo.Config do
  def current_scope do
    if Process.get(:_data_for_seo_api, nil), do: :process, else: :global
  end

  @doc """
  Get Auth configuration values.
  """
  def get, do: get(current_scope())

  def get(:global) do
    Application.get_env(:data_for_seo, :api, nil)
  end

  def get(:process), do: Process.get(:_data_for_seo_api, nil)

  @doc """
  Set Auth configuration values.
  """
  def set(value), do: set(current_scope(), value)
  def set(:global, value), do: Application.put_env(:data_for_seo, :api, value)

  def set(:process, value) do
    Process.put(:_data_for_seo_api, value)
    :ok
  end

  @doc """
  Get Auth configuration values in tuple format.
  """
  def get_tuples do
    case DataForSeo.Config.get() do
      nil -> []
      tuples -> tuples
    end
  end
end
