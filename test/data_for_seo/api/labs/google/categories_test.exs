defmodule DataForSeo.Api.Labs.Google.CategoriesTest do
  use ExUnit.Case

  alias DataForSeo.API.Labs.Google.Categories

  import RespFactory

  setup do
    bypass = Bypass.open()

    DataForSeo.Config.add(:process, base_url: "http://localhost:#{bypass.port}")

    {:ok, bypass: bypass}
  end

  test "read categories", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" = conn.method
      assert "/v3/dataforseo_labs/categories" = conn.request_path
      assert Enum.member?(conn.req_headers, {"content-type", "application/json"})

      assert {:ok, "", _} = Plug.Conn.read_body(conn)

      Plug.Conn.resp(
        conn,
        200,
        task_get_labs_google_categories()
      )
    end)

    assert {:ok, resp} = Categories.get_all_categories()

    assert %{"tasks" => [%{"result" => locations}], "tasks_count" => 1} = resp

    assert Enum.any?(
             locations,
             &(&1["category_name"] == "Apparel" and &1["category_code"] == 10021 and
                 &1["category_code_parent"] == nil)
           )

    assert Enum.any?(
             locations,
             &(&1["category_name"] == "Apparel Accessories" and &1["category_code"] == 10178 and
                 &1["category_code_parent"] == 10021)
           )
  end
end
