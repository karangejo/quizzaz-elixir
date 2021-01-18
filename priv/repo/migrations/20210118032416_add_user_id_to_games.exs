defmodule Quizzaz.Repo.Migrations.AddUserIdToGames do
  use Ecto.Migration

  def change do
    alter table(:games) do
      add :user_id, references(:users), on_delete: :delete_all
    end
  end
end
