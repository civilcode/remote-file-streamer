# RemoteFileStreamer

RemoteFileStreamer is a micro-library to stream a remote file.
Mostly, it provides a `stream` function taking a url as an input and returns a stream out of it.
If the server hosting the resource allows it, a file a streamed from a url

## Installation

The package is [available in Hex](https://hex.pm/packages/remote_file_streamer), and can be installed
by adding `file_streamer` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:file_streamer, "~> 0.1.0"}
  ]
end
```

## Examples

The following example will stream the content from the file located in the url, and consume the stream by outputing every chunks composing the resource:

```
  url
  |> RemoteFileStream.stream
  |> Enum.each(fn(chunk) -> IO.puts chunk end)
```  

# Documentation
- [HexDocs](https://hexdocs.pm/remote_file_streamer/0.1.0/api-reference.html)
- A usage of the library is described in [this blogpost](http://labs.civilcode.io/elixir/2018/05/03/stream-files.html).
