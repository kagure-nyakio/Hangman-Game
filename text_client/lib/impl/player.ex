defmodule TextClient.Impl.Player do
  @typep game :: Hangman.game
  @typep tally :: Hangman.tally
  @typep state :: { game, tally }

  @spec start(game) :: :ok
  def start(game) do
    tally = Hangman.tally(game)
    interact({game, tally})
  end

  def interact({_game, _tally = %{ game_state: :won}}), do: IO.puts "Congratulations, you won!"
  def interact({_game, tally  = %{game_state: :lost}}) do
    IO.puts "Sorry, you lost... the word was #{tally.letters |> Enum.join}"
  end

  @spec interact(state) :: :ok
  def interact({game, tally}) do
    IO.puts feedback_for(tally)
    IO.puts current_word(tally)

    tally = Hangman.make_move(game, get_guess())
    interact({ game, tally })
  end

  defp feedback_for(tally = %{game_state: :initializing}) do
    "Welcome, I'm thinking of a #{length(tally.letters)} letter word."
  end

  defp feedback_for(%{game_state: :good_guess}),    do: IO.ANSI.format([:cyan, "Good guess"])
  defp feedback_for(%{game_state: :bad_guess}),     do: IO.ANSI.format([:red, "Sorry, that's not in the word"])
  defp feedback_for(%{game_state: :already_used}),  do: IO.ANSI.format([:red, "You have already used that letter"])

  def current_word(tally) do
    [
      "Words so far: ", 
      tally.letters |> Enum.join(" "),
      IO.ANSI.format([:blue, " ,turns left: "]), 
      tally.turns_left |> to_string,
      IO.ANSI.format([:blue, " ,used: "]), 
      tally.used |> Enum.join(",")
    ]
  end

  def get_guess() do
    IO.gets("Next letter: ")
    |> String.trim
    |> String.downcase
  end
end
