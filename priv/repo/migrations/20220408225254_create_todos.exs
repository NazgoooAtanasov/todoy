defmodule Todos.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def up do
    create table(:todos) do
      add :title, :string
      add :description, :string

      timestamps()
    end

    flush()

  end

  def down do
    drop table(:todos)

    flush()

  end
end
