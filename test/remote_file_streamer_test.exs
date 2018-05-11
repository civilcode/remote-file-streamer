defmodule RemoteFileStreamerTest do
  use ExUnit.Case
  doctest RemoteFileStreamer

  defmodule TestHandler do
    def init(req0, state) do
      req = :cowboy_req.stream_reply(200, req0)

      "#{System.cwd()}/test/fixtures/emacs.png"
      |> File.read!()
      |> :binary.bin_to_list()
      |> Enum.chunk_every(2)
      |> Enum.each(fn chunk ->
        :cowboy_req.stream_body(chunk, :nofin, req)
      end)

      :cowboy_req.stream_body("", :fin, req)

      {:ok, req, state}
    end
  end

  setup_all do
    file_path = "#{System.cwd()}/test/fixtures/emacs.png"
    file_content = File.read!(file_path)
    path = "/remote_file"
    port = 4005
    listener_name = "listener_#{port}"

    dispatch =
      :cowboy_router.compile([
        {:_, [{path, TestHandler, []}]}
      ])

    {:ok, _} = :cowboy.start_clear(listener_name, [{:port, port}], %{env: %{dispatch: dispatch}})

    on_exit(fn ->
      :cowboy.stop_listener(listener_name)
    end)

    [expected_file_content: file_content]
  end

  describe "stream/1" do
    test "streams a remote url", %{expected_file_content: expected_file_content} do
      stream = RemoteFileStreamer.stream("http://localhost:4005/remote_file")

      rebuilt_resource =
        stream
        |> Enum.to_list()
        |> Enum.join()

      assert rebuilt_resource == expected_file_content
    end
  end
end
