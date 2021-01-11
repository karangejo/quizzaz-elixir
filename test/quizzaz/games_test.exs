defmodule Quizzaz.GamesTest do
  use Quizzaz.DataCase

  alias Quizzaz.Games

  describe "games" do
    alias Quizzaz.Games.Game

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Games.create_game(@valid_attrs)
      assert game.name == "some name"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, %Game{} = game} = Games.update_game(game, @update_attrs)
      assert game.name == "some updated name"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end

  describe "questions" do
    alias Quizzaz.Games.Question

    @valid_attrs %{answer_1: "some answer_1", answer_2: "some answer_2", answer_3: "some answer_3", answer_4: "some answer_4", correct_answer: 42, prompt: "some prompt"}
    @update_attrs %{answer_1: "some updated answer_1", answer_2: "some updated answer_2", answer_3: "some updated answer_3", answer_4: "some updated answer_4", correct_answer: 43, prompt: "some updated prompt"}
    @invalid_attrs %{answer_1: nil, answer_2: nil, answer_3: nil, answer_4: nil, correct_answer: nil, prompt: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Games.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Games.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Games.create_question(@valid_attrs)
      assert question.answer_1 == "some answer_1"
      assert question.answer_2 == "some answer_2"
      assert question.answer_3 == "some answer_3"
      assert question.answer_4 == "some answer_4"
      assert question.correct_answer == 42
      assert question.prompt == "some prompt"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, %Question{} = question} = Games.update_question(question, @update_attrs)
      assert question.answer_1 == "some updated answer_1"
      assert question.answer_2 == "some updated answer_2"
      assert question.answer_3 == "some updated answer_3"
      assert question.answer_4 == "some updated answer_4"
      assert question.correct_answer == 43
      assert question.prompt == "some updated prompt"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_question(question, @invalid_attrs)
      assert question == Games.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Games.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Games.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Games.change_question(question)
    end
  end
end
