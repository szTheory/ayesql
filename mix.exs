defmodule Ayesql.MixProject do
  use Mix.Project

  @version "0.6.0"
  @root "https://github.com/alexdesousa/ayesql"

  def project do
    [
      name: "AyeSQL",
      app: :ayesql,
      version: @version,
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      dialyzer: dialyzer(),
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  #############
  # Application

  defp elixirc_paths(:test) do
    ["lib", "test/support"]
  end

  defp elixirc_paths(_) do
    ["lib"]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto_sql, ">= 2.0.0", optional: true},
      {:postgrex, ">= 0.0.0", optional: true},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:credo, "~> 1.3", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false}
    ]
  end

  defp dialyzer do
    [
      plt_add_apps: [:ecto, :ecto_sql, :postgrex]
    ]
  end

  #########
  # Package

  defp package do
    [
      description: "Library for using raw SQL",
      files: [
        "src/queries_lexer.xrl",
        "src/queries_parser.yrl",
        "lib",
        "mix.exs",
        "LICENSE",
        "README.md",
        "CHANGELOG.md"
      ],
      maintainers: ["Alexander de Sousa"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "#{@root}/blob/master/CHANGELOG.md",
        "Github" => @root
      }
    ]
  end

  ###############
  # Documentation

  defp docs do
    [
      main: "readme",
      source_url: @root,
      source_ref: "v#{@version}",
      formatters: ["html"],
      extras: [
        "README.md"
      ],
      groups_for_modules: groups_for_modules()
    ]
  end

  defp groups_for_modules do
    [
      AyeSQL: [
        AyeSQL
      ],
      "AyeSQL Interpreter": [
        AyeSQL.Core,
        AyeSQL.Query,
        AyeSQL.Error
      ],
      "AyeSQL Parser": [
        AyeSQL.Parser,
        AyeSQL.AST,
        AyeSQL.AST.Context
      ],
      "AyeSQL runners": [
        AyeSQL.Runner,
        AyeSQL.Runner.Ecto,
        AyeSQL.Runner.Postgrex
      ]
    ]
  end
end
