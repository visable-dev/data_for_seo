defmodule DataForSeo.ConfigTest do
  use ExUnit.Case

  test "auth initialization global" do
    auth = [login: "login", password: "password"]
    DataForSeo.Config.set(auth)

    assert DataForSeo.Config.current_scope() == :global
    assert DataForSeo.Config.get() == auth
  end

  test "auth initialization (process)" do
    test = self()

    test_fun = fn test_pid, config ->
      spawn(fn ->
        DataForSeo.Config.set(:process, config)
        send(test_pid, {DataForSeo.Config.current_scope(), DataForSeo.Config.get()})
        exit(:normal)
      end)
    end

    test_fun.(test, conf: :process1)
    test_fun.(test, conf: :process2)

    assert_receive {:process, [conf: :process1]}
    assert_receive {:process, [conf: :process2]}
  end

  test "get_tuples returns list of tuples" do
    DataForSeo.Config.set(conf: "value")
    assert DataForSeo.Config.get_tuples() == [{:conf, "value"}]
  end

  test "get_tuples returns empty list when config is not set" do
    DataForSeo.Config.set(nil)

    assert DataForSeo.Config.get_tuples() == []
  end

  describe "add/1" do
    test "change options values" do
      old_config = DataForSeo.Config.get_tuples()
      DataForSeo.Config.add(login: "test")

      assert DataForSeo.Config.get_tuples() == Keyword.merge(old_config, login: "test")
    end
  end
end
