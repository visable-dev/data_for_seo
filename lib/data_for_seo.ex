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
  Provides general dataforseo API access interface.
  This method simply returns parsed json in Map structure.
  ## Examples
      DataForSeo.request(:get, "/v3/serp/google/languages")
  """
  @impl Behaviour
  defdelegate request(method, path), to: DataForSeo.API.Base

  @doc """
  Provides general dataforseo API access interface.
  This method simply returns parsed json in Map structure.
  ## Examples
      DataForSeo.request(:post, "/v3/serp/google/organic/task_post", [%{keyword: "Schrauben", language_code: "de-DE", location_name: "Hamburg,Hamburg,Germany", se_domain: "google.de"}])
  """
  @impl Behaviour
  defdelegate request(method, path, params), to: DataForSeo.API.Base

  @doc """
  POST /v3/serp/google/organic/task_post
  ## Examples
      DataForSeo.API.Serp.create_tasks("Schrauben")
      DataForSeo.API.Serp.create_tasks(["Schrauben", "Blumen"])
      DataForSeo.API.Serp.create_tasks(%{"Schrauben" => "123987", "Blumen" => "789231"})
      DataForSeo.API.Serp.create_tasks(%{"Schrauben" => "123987", "Blumen" => "789231"},  language_code: "de-DE", location_name: "20537,Hamburg,Germany", se_domain: "google.de")
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/task_post/
  """
  @impl Behaviour
  defdelegate create_tasks(keywords_data, params \\ []), to: DataForSeo.API.Serp

  @doc """
  GET /v3/serp/google/organic/tasks_ready
  ## Examples
      DataForSeo.completed_tasks
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/tasks_ready/
  """
  @impl Behaviour
  defdelegate completed_tasks, to: DataForSeo.API.Serp

  @doc """
  GET /v3/serp/google/organic/task_get/regular/$id
  ## Examples
      DataForSeo.task_result(123456789)
  ## Reference
  https://docs.dataforseo.com/v3/serp/google/organic/task_get/regular/
  """
  @impl Behaviour
  defdelegate task_result(task_id), to: DataForSeo.API.Serp
end
