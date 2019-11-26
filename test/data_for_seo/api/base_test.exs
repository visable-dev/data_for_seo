defmodule DataForSeo.Api.BaseTest do
  use ExUnit.Case
  import FakeServer

  alias DataForSeo.API

  describe "request_url/1" do
    test "it returnes full url" do
      assert API.Base.request_url("test/request") == "http://localhost/test/request"
    end
  end

  describe "request/3" do
    test_with_server "it makes get request if get method passed" do
      DataForSeo.Config.add(:process, base_url: FakeServer.http_address())
      route("/test", RespFactory.build(:basic_test))

      API.Base.request(:get, "test")

      assert request_received("/test", method: "GET", count: 1)
    end

    test_with_server "it makes GET request with query params" do
      DataForSeo.Config.add(:process, base_url: FakeServer.http_address())
      route("/test", RespFactory.build(:basic_test))

      params = [param1: "value1", param2: "value2"]
      API.Base.request(:get, "test", params)

      assert request_received("/test", method: "GET", query: Enum.into(params, %{}), count: 1)
    end

    test_with_server "it makes post request if post method passed" do
      DataForSeo.Config.add(:process, base_url: FakeServer.http_address())
      route("/test", RespFactory.build(:basic_test))

      API.Base.request(:post, "test")

      assert request_received("/test", method: "POST", count: 1)
    end

    test_with_server "it makes POST request with body params" do
      DataForSeo.Config.add(:process, base_url: FakeServer.http_address())
      route("/test", RespFactory.build(:basic_test))

      params = [param1: "value1", param2: "value2"]
      API.Base.request(:post, "test", params)

      assert request_received("/test", method: "POST", query: Enum.into(params, %{}), count: 1)
    end

    test_with_server "it adds default headers to request" do
      DataForSeo.Config.set(:process,
        base_url: FakeServer.http_address(),
        login: "test",
        password: "test"
      )

      route("/test", RespFactory.build(:basic_test))

      default_headers = [
        {"content-type", "application/json"},
        Mojito.Headers.auth_header("test", "test")
      ]

      API.Base.request(:post, "test")

      assert(
        request_received(
          "/test",
          method: "POST",
          headers: Enum.into(default_headers, %{}),
          count: 1
        )
      )
    end

    test_with_server "it works with bad responces" do
      DataForSeo.Config.set(:process, base_url: FakeServer.http_address())
      route("/test", RespFactory.build(:bad))

      response = API.Base.request(:post, "test")

      assert {:error, %{"code" => _, "message" => _}} = response
    end
  end
end
