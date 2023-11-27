defmodule DataForSeo.Api.SERP.Google.LocationTest do
  use ExUnit.Case

  alias DataForSeo.API.SERP.Google.Location

  import RespFactory

  setup do
    bypass = Bypass.open()

    DataForSeo.Config.add(:process, base_url: "http://localhost:#{bypass.port}")

    {:ok, bypass: bypass}
  end

  test "read locations by country", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" = conn.method
      assert "/v3/serp/google/locations/lu" = conn.request_path
      assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

      assert {:ok, "", _} = Plug.Conn.read_body(conn)

      Plug.Conn.resp(
        conn,
        200,
        task_get_serp_google_location_by_country("lu")
      )
    end)

    assert {:ok, resp} = Location.get_location_by_service_and_country("google", "lu")

    assert %{"tasks" => [%{"result" => locations}], "tasks_count" => 1} = resp

    assert Enum.any?(
             locations,
             &(&1["location_type"] == "Country" and &1["location_name"] == "Luxembourg")
           )

    assert Enum.any?(
             locations,
             &(&1["location_type"] == "City" and &1["location_name"] == "Kaerjeng,Luxembourg")
           )
  end
end
