defmodule FileStreamer.MixProject do
  use Mix.Project

  def project do
    [
      app: :file_streamer,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()

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
      {:httpoison, "~> 0.13.0"},
      {:cowboy, "~> 2.4", only: :test}
    ]
  end

  defp package do
    [
      maintainers: ["Nicolas Charlery"],
      licenses: ["MIT"],
      links: %{"Civilcode Labs" => "http://labs.civilcode.io"}
    ]
  end
end
