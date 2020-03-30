defmodule DataForSeo do
  @moduledoc """
  Provides access interfaces for the DataForSeo V3 API.
  """

  alias DataForSeo.Behaviour
  @behaviour Behaviour

  # -------------- DataForSeo Settings -------------

  @doc """
  Provides DataForSeo configuration settings for accessing dataforseo server.
  The specified configuration applies globally. Use `DataForSeo.configure/2`
  for setting different configurations on each processes.
  ## Examples
      DataForSeo.configure(
        login: System.get_env("DATAFORSEO_LOGIN"),
        password: System.get_env("DATAFORSEO_PASSWORD")
      )
  """
  @impl Behaviour
  defdelegate configure(auth), to: DataForSeo.Config, as: :set

  @doc """
  Provides Auth configuration settings for accessing dataforseo server.
  ## Options
    The `scope` can have one of the following values.
    * `:global` - configuration is shared for all processes.
    * `:process` - configuration is isolated for each process.
  ## Examples
      DataForSeo.configure(
        :process,
        login: System.get_env("DATAFORSEO_LOGIN"),
        password: System.get_env("DATAFORSEO_PASSWORD")
      )
  """
  @impl Behaviour
  defdelegate configure(scope, auth), to: DataForSeo.Config, as: :set

  @doc """
  Returns current Auth configuration settings for accessing dataforseo server.
  """
  @impl Behaviour
  defdelegate configure, to: DataForSeo.Config, as: :get

  @doc """
  POST /v3/serp/google/organic/task_post
  ## Examples
      DataForSeo.API.Serp.task_post("Schrauben")
      DataForSeo.API.Serp.task_post(["Schrauben", "Blumen"])
      DataForSeo.API.Serp.task_post(%{"Schrauben" => "123987", "Blumen" => "789231"})
      DataForSeo.API.Serp.task_post(%{"Schrauben" => "123987", "Blumen" => "789231"},  language_code: "de-DE", location_name: "20537,Hamburg,Germany", se_domain: "google.de")
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/task_post/
  """
  @impl Behaviour
  defdelegate task_post(keywords_data, params \\ []), to: DataForSeo.API.Serp

  @doc """
  GET /v3/serp/google/organic/tasks_ready
  ## Examples
      DataForSeo.tasks_ready()
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/tasks_ready/
  """
  @impl Behaviour
  defdelegate tasks_ready, to: DataForSeo.API.Serp

  @doc """
  GET /v3/serp/google/organic/task_get/regular/$id
  ## Examples
      DataForSeo.task_get("03301617-9324-0066-0000-472866f98a6e")
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/task_get/regular/
  """
  @impl Behaviour
  defdelegate task_get(task_id, type \\ :regular), to: DataForSeo.API.Serp
end
