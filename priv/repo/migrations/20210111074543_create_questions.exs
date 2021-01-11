defmodule Quizzaz.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :prompt, :string
      add :correct_answer, :integer
      add :answer_1, :string
      add :answer_2, :string
      add :answer_3, :string
      add :answer_4, :string
      add :game_id, references(:games)

      timestamps()
    end

  end
end
