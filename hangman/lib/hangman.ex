

#API CODE ONLY
defmodule Hangman do
  alias Hangman.Game #will now refer to only the part after the period ""

  defdelegate new_game(), to: Game
  defdelegate tally(game), to: Game
  defdelegate make_move(game, guess), to: Game

end
