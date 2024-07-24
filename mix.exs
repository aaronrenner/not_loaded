defmodule NotLoaded.Mixfile do
  use Mix.Project

  @version "0.3.0"
  @maintainers ["Aaron Renner"]
  @source_url "https://github.com/aaronrenner/not_loaded"

  def project do
    [
      app: :not_loaded,
      version: @version,
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),

      # Docs
      name: "NotLoaded",
      docs: docs(),
      dialyzer: dialyzer(System.get_env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application, do: []

  defp elixirc_paths(:test), do: ["test/support", "lib"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end

  # Run "mix help docs" to learn about docs
  defp docs do
    [
      source_url: @source_url,
      source_rev: "v#{@version}"
    ]
  end

  defp description do
    "Placeholders for data that isn't loaded. Inspired by Ecto."
  end

  defp package do
    [
      maintainers: @maintainers,
      licenses: ["MIT"],
      links: %{
        "Github" => @source_url
      }
    ]
  end

  #
  # Environment specific dialyzer config
  defp dialyzer(%{"CI" => "true"}) do
    [
      plt_core_path: ".dialyzer/core",
      plt_local_path: ".dialyzer/local"
    ]
  end

  defp dialyzer(_), do: []
end
