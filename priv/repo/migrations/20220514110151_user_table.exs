defmodule Todos.Repo.Migrations.UserTable do
  use Ecto.Migration

  def change do
    alter table :tables do
      add :user_id, references(:users)
    end
  end
end
