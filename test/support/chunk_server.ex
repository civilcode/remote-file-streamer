defmodule ChunkServer do
  defmodule Handler do
    def init(req0, %{file_path: resource_path} = state) do
      req = :cowboy_req.stream_reply(200, req0)

      resource_path
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

  def start(port, path, resource_path) do
    listener_name = "listener_#{port}"

    dispatch =
      :cowboy_router.compile([
        {:_, [{path, Handler, %{file_path: resource_path}}]}
      ])

    {:ok, _} = :cowboy.start_clear(listener_name, [{:port, port}], %{env: %{dispatch: dispatch}})
  end

  def stop(listener) do
    :cowboy.stop_listener(listener)
  end
end
