defmodule Drax.Mixfile do
  use Mix.Project

  def project do
    [
      app: :drax,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),

      # Package stuff
      description: description(),
      package: package(),
      name: "Drax",
      source_url: "https://github.com/keathley/drax",
      docs: docs(),
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
      {:propcheck, "~> 1.1", only: [:dev, :test]},
      {:ex_doc, "~> 0.19", only: [:dev, :test]},
    ]
  end

  def description do
    """
    Drax provides a group of common CRDTs.
    """
  end

  def package do
    [
      name: "drax",
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/keathley/drax"},
    ]
  end

  def docs do
    [
      main: "Drax",
    ]
  end
end
