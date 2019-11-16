defmodule DataForSeo.Error do
  defexception [:code, :message]
end

defmodule DataForSeo.ConnectionError do
  defexception [:reason, message: "connection error"]
end
