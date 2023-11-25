defmodule DataForSeo.Api.Keywords.GoogleAds.LanguagesTest do
  use ExUnit.Case

  alias DataForSeo.API.Keywords.GoogleAds.Languages

  import RespFactory

  setup do
    bypass = Bypass.open()

    DataForSeo.Config.add(:process, base_url: "http://localhost:#{bypass.port}")

    {:ok, bypass: bypass}
  end

  test "read languages", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" = conn.method
      assert "/v3/keywords_data/google_ads/languages" = conn.request_path
      assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

      assert {:ok, "", _} = Plug.Conn.read_body(conn)

      Plug.Conn.resp(
        conn,
        200,
        task_get_google_ads_languages()
      )
    end)

    assert {:ok, resp} = Languages.get_all_languages()

    assert %{"tasks" => [%{"result" => languages}], "tasks_count" => 1} = resp

    assert Enum.any?(
             languages,
             &(&1["language_name"] == "Bulgarian" and &1["language_code"] == "bg")
           )

    assert Enum.any?(
             languages,
             &(&1["language_name"] == "Croatian" and &1["language_code"] == "hr")
           )
  end
end
