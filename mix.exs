defmodule DataForSeo.MixProject do
  use Mix.Project

  @source_url "https://gitlab.com/egze/data_for_seo"

  def project do
    [
      app: :data_for_seo,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: @source_url,
      name: "DataForSeo",
      docs: [main: DataForSeo],
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mojito, "~> 0.5.0"},
      {:jason, "~> 1.1"},
      {:fake_server, "~> 2.1", only: :test},
      {:ex_doc, ">= 0.0.0", only: [:dev, :docs]}
    ]
  end

  defp description do
    """
    DataForSEO client library for elixir.
    """
  end

  defp package do
    [
      maintainers: ["egze"],
      licenses: ["MIT"],
      links: %{"GitLab" => @source_url}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
