defmodule QuizzazWeb.GameLive.Show do
  use QuizzazWeb, :live_view

  alias Quizzaz.Games
  alias Quizzaz.Games.Question

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, show_question_form: false)
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:question, %Question{})
     |> assign(:game, Games.get_game!(id))}
  end

  def handle_event("show-question-form", _params, socket) do
    socket = assign(socket, show_question_form: true)
    {:noreply, socket}
  end

  defp page_title(:show), do: "Show Game"
  defp page_title(:edit), do: "Edit Game"
end
