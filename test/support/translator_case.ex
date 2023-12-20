defmodule DataForSeo.TranslatorCase do
  defmacro __using__(_) do
    quote do
      import DataForSeo.Test.ResponseFactory
      alias DataForSeo.DataModel.Generic.Task
      alias DataForSeo.DataModel.Transform.ResponseTranslator

      defp translate_task_from_fixture(path) do
        path
        |> get_json_fixture()
        |> ResponseTranslator.load_response()
        |> ResponseTranslator.get_tasks()
        |> hd()
        |> ResponseTranslator.load_task_result()
      end
    end
  end
end
