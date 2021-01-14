defmodule QuizzazWeb.GameLive.Show do
  use QuizzazWeb, :live_view

  alias Quizzaz.Games
  alias Quizzaz.Games.Question

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(show_new_question_form: false)
      |> assign(question_to_edit: 0)

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign( show_new_question_form: false)
     |> assign( question_to_edit: 0)
     |> assign(:question, %Question{})
     |> assign(:game, Games.get_game!(id))}
  end

  @impl true
  def handle_event("show-new-question-form", _params, socket) do
    socket =
      socket
      |> assign(show_new_question_form: true)

    {:noreply, socket}
  end

  @impl true
  def handle_event("show-edit-question-form", %{"id" => id}, socket) do
    socket =
      socket
      |> assign( question_to_edit: String.to_integer(id))

    {:noreply, socket}
  end

  @impl true
  def handle_event("delete-question", %{"id" => id, "game-id" => game_id}, socket) do
    question = Games.get_question!(id)
    {:ok, _} = Games.delete_question(question)

    {:noreply, assign(socket, :game, Games.get_game!(game_id))}
  end

  defp page_title(:show), do: "Show Game"
  defp page_title(:edit), do: "Edit Game"
end
