defmodule IslandsEngine.Game do
  use GenServer
  alias IslandsEngine.{Board, Guesses, Rules}

  def start_link(name) when is_binary(name), do:
  GenServer.start_link(__MODULE__, name, [])
end
