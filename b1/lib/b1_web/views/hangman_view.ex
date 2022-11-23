defmodule B1Web.HangmanView do
  use B1Web, :view
  
  #map a css class and a message (could also have multiclause functions in place of this)
  @status_fields %{
    initializing: {"initializing", "Guess the word, a letter at a time"},
    good_guess:   {"good-guess", "Good guess"},
    bad_guess:    {"bad-guess", "Sorry, that's not in the word."},
    won:          {"won", "Yay! You won!"},
    lost:         {"lost", "Sorry, you lost."},
    already_used: {"already-used", "You already used that letter"}
  }

  def move_status(status) do 
    { class, msg } = @status_fields[status]
    "<div class='status #{class}'>#{msg}</div>"
  end

  def continue_or_try_again(conn, status) when status in [:won, :lost] do
    button("Try again", to: Routes.hangman_path(conn, :new))
  end
  
  def continue_or_try_again(conn, _status) do
		form_for(conn, Routes.hangman_path(conn, :update), [ as: "make_move", method: :put ], fn f -> 
      # to return both of this(input and submit -> wrap in a list
      [
      text_input(f, :guess),
      submit("Make next guess") 
      ]
		 end) 
  end

  defdelegate figure_for(turns_left), to: B1Web.HangmanView.Helpers.FigureFor

end
