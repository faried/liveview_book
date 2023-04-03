defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    r = :rand.uniform(10) |> Integer.to_string()
    IO.inspect(r, label: "random")

    {:ok,
     assign(socket,
       score: 0,
       message: "Make a guess:",
       random: r
     )}
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {message, score} =
      if guess == socket.assigns.random do
        {"Correct!", socket.assigns.score + 1}
      else
        {"Your guess: #{guess}. Wrong. Guess again. ", socket.assigns.score - 1}
      end

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score
      )
    }
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2><%= @message %></h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number={n}>
          <%= n %>
        </.link>
      <% end %>
    </h2>
    <pre>
      <%= @current_user.email %>
      <%= @session_id %>
    </pre>
    """
  end
end
