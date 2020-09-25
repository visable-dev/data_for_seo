# DataForSeo

[![Hex version badge](https://img.shields.io/hexpm/v/data_for_seo.svg)](https://hex.pm/packages/data_for_seo) [![HexDocs](https://img.shields.io/badge/api-docs-yellow.svg?style=flat)](https://hexdocs.pm/data_for_seo/)

DataForSeo client library for Elixir.

It only supports very limited set of functions yet. Refer to [data_for_seo.ex](https://gitlab.com/visable/data_for_seo/blob/master/lib/data_for_seo.ex) for available functions and examples.

## Docs

Docs can be found at [https://hexdocs.pm/data_for_seo](https://hexdocs.pm/data_for_seo)

## Installation

The package can be installed by adding `data_for_seo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:data_for_seo, "~> 0.4.0"}
  ]
end
```

## Configuration

Add to your `config.exs` and make sure the ENVs below are set.

```elixir
config :data_for_seo, :api,
  base_url: "https://api.dataforseo.com",
  login: System.get_env("DATAFORSEO_LOGIN"),
  password: System.get_env("DATAFORSEO_PASSWORD")
```