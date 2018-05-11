defmodule RemoteFileStreamer.MixProject do
  use Mix.Project

  @version "0.1.0"
  @project_url "https://github.com/civilcode/remote_file_streamer"

  def project do
    [
      app: :remote_file_streamer,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application() do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps() do
    [
      {:httpoison, "~> 0.11"},
      {:cowboy, "~> 2.4", only: :test},
      {:mix_test_watch, "~> 0.6", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      maintainers: ["Nicolas Charlery"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/civilcode/remote_file_streamer",
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
