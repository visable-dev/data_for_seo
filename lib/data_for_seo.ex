defmodule DataForSeo do
  @moduledoc """
  Provides access interfaces for the DataForSeo API.
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
      DataForSeo.request(:get, "v2/cmn_user")
  """
  @impl Behaviour
  defdelegate request(method, path), to: DataForSeo.API.Base

  @doc """
  Provides general dataforseo API access interface.
  This method simply returns parsed json in Map structure.
  ## Examples
      DataForSeo.request(:post, "v2/srp_tasks_post", [priority: 1, se_name: "google.de", se_language: "German", loc_name_canonical: "Hamburg,Germany", key: "Schrauben"])
  """
  @impl Behaviour
  defdelegate request(method, path, params), to: DataForSeo.API.Base

  @doc """
  POST v2/srp_tasks_post
  ## Examples
      DataForSeo.create_tasks(%{"Schrauben" => "123987"}, "German", "20537,Hamburg,Germany", "google.de")
  ## Reference
  https://docs.dataforseo.com/v2/srp#setting-serp-tasks
  """
  @impl Behaviour
  defdelegate create_tasks(
                keys_with_unique_ids,
                se_language,
                loc_name_canonical,
                se_name,
                optional_params \\ []
              ),
              to: DataForSeo.API.Serp

  @doc """
  GET v2/srp_tasks_get
  ## Examples
      DataForSeo.completed_tasks
  ## Reference
  https://docs.dataforseo.com/v2/srp#get-serp-completed-tasks
  """
  @impl Behaviour
  defdelegate completed_tasks, to: DataForSeo.API.Serp

  @doc """
  GET v2/srp_tasks_get
  ## Examples
      DataForSeo.task_result(123456789)
  ## Reference
  https://docs.dataforseo.com/v2/srp#get-serp-results-by-task_id
  """
  @impl Behaviour
  defdelegate task_result(task_id), to: DataForSeo.API.Serp
end
