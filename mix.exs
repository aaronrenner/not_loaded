defmodule NotLoaded.Mixfile do
  use Mix.Project

  @version "0.1.0"
  @maintainers ["Aaron Renner"]
  @source_url "https://github.com/aaronrenner/not_loaded"

  def project do
    [
      app: :not_loaded,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),

      # Docs
      name: "NotLoaded",
      docs: docs(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application, do: []

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
    ]
  end

  # Run "mix help docs" to learn about docs
  defp docs do
    [
      source_url: @source_url,
      source_rev: "v#{@version}",
    ]
  end

  defp description do
    "Helpers for working with data that hasn't been loaded. Inspired by Ecto"
  end

  defp package do
    [
      maintainers: @maintainers,
      licenses: ["MIT"],
      links: %{
        "Github" => @source_url
      },
    ]
  end
end
