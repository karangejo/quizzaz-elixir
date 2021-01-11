defmodule Quizzaz.Games.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :answer_1, :string
    field :answer_2, :string
    field :answer_3, :string
    field :answer_4, :string
    field :correct_answer, :integer
    field :prompt, :string
    belongs_to :game, Quizzaz.Games.Game

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:prompt, :correct_answer, :answer_1, :answer_2, :answer_3, :answer_4])
    |> validate_required([:prompt, :correct_answer, :answer_1, :answer_2, :answer_3, :answer_4])
  end
end
