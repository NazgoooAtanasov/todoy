defmodule Todos.Repo.Migrations.TableTodo do
  use Ecto.Migration

  def change do
    create table(:tables) do
      add :title, :string
      add :description, :string

      timestamps()
    end

    alter table(:todos) do
      add :table_id, references(:tables)
    end
  end
end
