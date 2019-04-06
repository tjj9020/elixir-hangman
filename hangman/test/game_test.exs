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

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is not already used" do
    game = Game.new_game()
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_used
    
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "guess whole word is a won game" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    {game, _tally} = Game.make_move(game, "i")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    {game, _tally} = Game.make_move(game, "b")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    {game, _tally} = Game.make_move(game, "l")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    {game, _tally} = Game.make_move(game, "e")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

end
