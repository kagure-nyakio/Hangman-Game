defmodule LiveviewClientWeb.Live.Game.WordsSoFar do
  
  use LiveviewClientWeb, :live_component

    @states %{
      initializing: "Type or click on your first guess.",
      good_guess:   "Good guess!",
      bad_guess:    "Sorry, that's not in the word.",
      won:          "Yay! You won!",
      lost:         "Sorry, you lost.",
      already_used: "You already used that letter"
  }

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="words_so_far">
      <div class="game_state">
        <%= state_name(@tally.game_state) %>
      </div>

      <div class="letters">
        <%= for ch <- @tally.letters do %>
          <% cls = if ch != "_", do: "one-letter correct", else: "one-letter" %>
          <div class={cls}>
            <%= ch %>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  defp state_name(state), do: @states[state] || "Unknown State"
end
