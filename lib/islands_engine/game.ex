defmodule IslandsEngine.Game do
  use GenServer
  alias IslandsEngine.{Board, Coordinate, Guesses, Island, Rules}

  @players [:player1, :player2]
  
  def start_link(name) when is_binary(name), do:
  GenServer.start_link(__MODULE__, name, [])

  def init(name) do
    player1 = %{name: name, board: Board.new(), guesses: Guesses.new()}
    player2 = %{name: nil,  board: Board.new(), guesses: Guesses.new()}
    {:ok, %{player1: player1, player2: player2, rules: %Rules{}}}
  end


  def add_player(game, name), do:
  GenServer.call(game, {:add_player, name})

  def handle_call({:add_player, name}, _from, state_data) do
    with {:ok, rules} <- Rules.check(state_data.rules, :add_player)
      do
      state_data
      |> update_player2_name(name)
      |> update_rules(rules)
      |> reply_success(:ok)
      else
	:error -> {:reply, :error, state_data}
    end
  end

  defp update_player2_name(state_data, name), do:
  put_in(state_data.player2.name, name)

  defp update_rules(state_data, rules), do: %{state_data | rules: rules}

  def reply_success(state_data, reply), do: {:reply, reply, state_data}

  def position_island(game, player, key, row, col) when player in @players, do:
  GenServer.call(game, {:position_island, player, key, row, col})

  defp player_board(state_data, player), do: Map.get(state_data, player).board

  defp update_board(state_data, player, board), do:
  Map.update!(state_data, player, fn player -> %{player | board: board} end)
  
end
