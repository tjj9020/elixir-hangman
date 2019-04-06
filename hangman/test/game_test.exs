defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0

    results = for l <- game.letters, do: l =~ ~r(^[^A-Z]*$)
    assert results
  end

  test "state isnt changed for :won/:lost game" do
    for state <- [ :won, :lost ] do
      game = Game.new_game()
        |> Map.put(:game_state, state)
      assert { ^game, _ } = Game.make_move(game, "x")
    end
  end

end
