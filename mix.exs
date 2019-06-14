defmodule RemoteFileStreamer.MixProject do
  use Mix.Project

  @version "1.0.0"
  @project_url "https://github.com/civilcode/remote-file-streamer"

  def project do
    [
      app: :remote_file_streamer,
      version: @version,
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application() do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps() do
    [
      {:httpoison, ">= 0.0.0"},
      {:cowboy, ">= 2.0.0", only: :test},
      {:mix_test_watch, "~> 0.6", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package() do
    [
      maintainers: ["Nicolas Charlery"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/civilcode/remote-file-streamer",
        "Civilcode Labs" => "http://labs.civilcode.io"
      },
      source_url: @project_url,
      homepage_url: @project_url
    ]
  end

  defp description() do
    """
    RemoteFileStreamer is a micro-library to stream a remote file.
    It's similar to File.stream! but takes an url as input and returns a stream to consume.
    """
  end
end
