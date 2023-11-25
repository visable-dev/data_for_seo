defmodule DataForSeo.API.SERP.Google.Organic do
  @moduledoc """
  Provides SERP Google API interfaces to organic search results
  It's a wrapper b/c original lib had no namespaces and implementation is at `DataForSeo.API.Serp`
  At the moment it's only import existing module but here is a room to improvements and keeping back compatibilities
  at the same time.
  """

  import DataForSeo.API.Serp
end
