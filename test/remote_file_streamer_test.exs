defmodule RemoteFileStreamerTest do
  use ExUnit.Case
  doctest RemoteFileStreamer

  setup_all do
    file_path = "#{File.cwd!()}/test/fixtures/emacs.png"

    listener = ChunkServer.start(4006, "/remote_file", file_path)

    on_exit(fn ->
      ChunkServer.stop(listener)
    end)

    [file_path: file_path]
  end

  describe "stream/1" do
    test "streams a remote url", %{file_path: file_path} do
      received_file_content =
        "http://localhost:4006/remote_file"
        |> RemoteFileStreamer.stream()
        |> Enum.to_list()
        |> Enum.join()

      expected_file_content = File.read!(file_path)
      assert received_file_content == expected_file_content
    end
  end
end
