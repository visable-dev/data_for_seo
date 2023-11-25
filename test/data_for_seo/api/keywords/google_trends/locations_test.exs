defmodule DataForSeo.Api.Keywords.GoogleTrends.LocationsTest do
  use ExUnit.Case

  alias DataForSeo.API.Keywords.GoogleTrends.Locations

  import RespFactory

  setup do
    bypass = Bypass.open()

    DataForSeo.Config.add(:process, base_url: "http://localhost:#{bypass.port}")

    {:ok, bypass: bypass}
  end

  test "read all locations", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" = conn.method
      assert "/v3/keywords_data/google_trends/locations" = conn.request_path
      assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

      assert {:ok, "", _} = Plug.Conn.read_body(conn)

      Plug.Conn.resp(
        conn,
        200,
        task_get_google_trend_locations()
      )
    end)

    assert {:ok, resp} = Locations.get_all_locations()

    assert %{"tasks" => [%{"result" => locations}], "tasks_count" => 1} = resp

    loc = %{
      "location_code" => 2004,
      "location_name" => "Afghanistan",
      "location_code_parent" => nil,
      "country_iso_code" => "AF",
      "location_type" => "Country",
      "geo_name" => "Afghanistan",
      "geo_id" => "AF"
    }

    assert Enum.any?(locations, &(&1 == loc))
  end

  test "read locations by country", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" = conn.method
      assert "/v3/keywords_data/google_trends/locations/ua" = conn.request_path
      assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

      assert {:ok, "", _} = Plug.Conn.read_body(conn)

      Plug.Conn.resp(
        conn,
        200,
        task_get_google_trend_locations_by_country("ua")
      )
    end)

    assert {:ok, resp} = Locations.get_all_locations_by_country("ua")

    assert %{"tasks" => [%{"result" => locations}], "tasks_count" => 1} = resp

    loc = %{
      "location_code" => 21113,
      "location_name" => "Donetsk Oblast,Ukraine",
      "location_code_parent" => 2804,
      "country_iso_code" => "UA",
      "location_type" => "Region",
      "geo_name" => "Donetsk Oblast,Ukraine",
      "geo_id" => "Donetsk Oblast,Ukraine"
    }

    assert Enum.any?(locations, &(&1 == loc))
  end
end
