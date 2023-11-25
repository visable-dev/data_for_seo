defmodule DataForSeo.Api.Keywords.GoogleAds.LocationsTest do
  use ExUnit.Case

  alias DataForSeo.API.Keywords.GoogleAds.Locations

  import RespFactory

  setup do
    bypass = Bypass.open()

    DataForSeo.Config.add(:process, base_url: "http://localhost:#{bypass.port}")

    {:ok, bypass: bypass}
  end

  test "read all locations", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" = conn.method
      assert "/v3/keywords_data/google_ads/locations" = conn.request_path
      assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

      assert {:ok, "", _} = Plug.Conn.read_body(conn)

      Plug.Conn.resp(
        conn,
        200,
        task_get_google_ads_locations()
      )
    end)

    assert {:ok, resp} = Locations.get_all_locations()

    assert %{"tasks" => [%{"result" => locations}], "tasks_count" => 1} = resp

    loc = %{
      "location_code" => 21133,
      "location_name" => "Alabama,United States",
      "location_code_parent" => 2840,
      "country_iso_code" => "US",
      "location_type" => "State"
    }

    assert Enum.any?(locations, &(&1 == loc))
  end
end
