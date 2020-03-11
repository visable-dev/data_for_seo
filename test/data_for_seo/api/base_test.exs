defmodule DataForSeo.Api.BaseTest do
  use ExUnit.Case

  alias DataForSeo.API

  setup do
    bypass = Bypass.open()

    DataForSeo.Config.add(:process, base_url: "http://localhost:#{bypass.port}")

    {:ok, bypass: bypass}
  end

  describe "request_url/1" do
    test "it returnes full url", %{bypass: bypass} do
      assert API.Base.request_url("/test/request") == "http://localhost:#{bypass.port}/test/request"
    end
  end

  describe "request/3" do
    test "it makes GET request with query params", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        conn = Plug.Conn.fetch_query_params(conn)

        assert "GET" = conn.method
        assert "/test" = conn.request_path
        assert %{"param1" => "value1", "param2" => "value2"} = conn.query_params

        Plug.Conn.resp(conn, 200, "[]")
      end)

      API.Base.request(:get, "/test", [param1: "value1", param2: "value2"])
    end

    test "it makes POST request with body params", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/test" = conn.request_path

        {:ok, body, _} = Plug.Conn.read_body(conn)
        assert body == Jason.encode!(%{param1: "value1", param2: "value2"})

        Plug.Conn.resp(conn, 200, "[]")
      end)

      API.Base.request(:post, "/test", %{param1: "value1", param2: "value2"})
    end

    test "it adds default headers to request", %{bypass: bypass} do
      DataForSeo.Config.set(:process, login: "test", password: "test", base_url: "http://localhost:#{bypass.port}")

      Bypass.expect(bypass, fn conn ->
        assert "POST" = conn.method
        assert "/test" = conn.request_path
        assert Enum.member?(conn.req_headers, {"content-type", "application/json"})
        assert Enum.member?(conn.req_headers, Mojito.Headers.auth_header("test", "test"))

        Plug.Conn.resp(conn, 200, "[]")
      end)

      API.Base.request(:post, "/test")
    end

    test "it works with bad responces", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        Plug.Conn.resp(conn, 500, "{\"error\": {\"code\": 1234, \"message\":\"Error\"}}")
      end)

      response = API.Base.request(:post, "/test")

      assert {:error, %{"code" => 1234, "message" => "Error"}} = response
    end
  end
end
