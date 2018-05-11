defmodule FileStreamer do
  @moduledoc """
  FileStreamer is a micro-library to stream a remote file.
  Mostly, it provides a `stream` function taking a url as an input and returns a stream out of it.
  """

  @doc """
  If the server hosting the resource allows it, a file a streamed from a url
  Hello world.

  ## Examples

  url
  |> FileStream.stream
  |> Enum.each(fn(chunk) -> IO.puts chunk end)

  """
  @spec stream(String.t()) :: Enumerable.t()
  def stream(url) do
    Stream.resource(fn -> build_stream(url) end, fn resp -> read_stream(resp) end, fn _resp ->
      :ok
    end)
  end

  defp build_stream(remote_file_url) do
    HTTPoison.get!(remote_file_url, [], stream_to: self(), async: :once)
  end

  defp read_stream(resp) do
    %HTTPoison.AsyncResponse{id: ref} = resp

    receive do
      %HTTPoison.AsyncStatus{id: ^ref} ->
        continue(resp)

      %HTTPoison.AsyncHeaders{id: ^ref} ->
        continue(resp)

      %HTTPoison.AsyncChunk{chunk: chunk, id: ^ref} ->
        _ = stream_next(resp)
        {[chunk], resp}

      %HTTPoison.AsyncEnd{id: ^ref} ->
        {:halt, resp}
    end
  end

  defp continue(resp) do
    resp
    |> stream_next
    |> read_stream
  end

  defp stream_next(resp) do
    {:ok, ^resp} = HTTPoison.stream_next(resp)
    resp
  end
end
