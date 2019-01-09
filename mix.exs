defmodule Todo.MixProject do
  use Mix.Project

  def project do
    [
      app: :todo,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Todo.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.1"},
      {:distillery, "~> 2.0"},
      {:libcluster, "~> 3.0"},
      {:plug, "~> 1.4"},
      {:plug_cowboy, "~> 1.0"},
      {:poolboy, "~> 1.5"},
      {:redix, "~> 0.9"}
    ]
  end
end
