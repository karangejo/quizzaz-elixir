defmodule QuizzazWeb.GameLive.Index do
  use QuizzazWeb, :live_view

  alias Quizzaz.Games
  alias Quizzaz.Games.Game
  alias Quizzaz.Accounts

  @impl true
  def mount(_params, session, socket) do
    case Map.fetch(session, "user_token") do
      {:ok, token} ->
        user = Accounts.get_user_by_session_token(token)
        {:ok, assign(socket, games: list_user_games(user), current_user: user)}
      :error ->
        {:ok, assign(socket, :games, list_games())}
    end
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Game")
    |> assign(:game, Games.get_game!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Game")
    |> assign(:game, %Game{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Browse Games")
    |> assign(:game, nil)
    |> assign(:games, list_games())
  end

  defp apply_action(socket, :mygames, _params) do
    socket
    |> assign(:page_title, "My Games")
    |> assign(:games, list_user_games(socket.assigns.current_user))
    |> assign(:game, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    game = Games.get_game!(id)
    {:ok, _} = Games.delete_game(game)

    {:noreply, assign(socket, :games, list_games())}
  end

  defp list_games do
    Games.list_games()
  end

  defp list_user_games(user) do
    Games.list_games(user)
  end
end
