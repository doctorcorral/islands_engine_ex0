defmodule IslandsEngine.Game do
  use GenServer

  def handle_call(:demo_call, _from, state) do
    {:reply, state, %{state | test: state.test <> "|"}}
  end

  def handle_cast({:demo_cast, new_value}, state) do
    {:noreply, Map.put(state, :test, new_value)}
  end
  
  def demo_call(game) do
    GenServer.call(game, :demo_call)
  end

  def demo_cast(pid, new_value) do
    GenServer.cast(pid, {:demo_cast, new_value})
  end
  
  def handle_info(:first, state) do
    IO.puts "This message has been handled by handle_info/2, matching on :first"
    {:noreply, state}
  end
end
