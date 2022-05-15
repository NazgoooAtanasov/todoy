defmodule Todos.TableManager.TableRepo do
  import Todos.Repo
  import Ecto.Query

  alias Todos.Table

  def list_tables, do: 
    all(Table) 
    |> Todos.Repo.preload(:todos)

  def create_table(attrs, user) do
    Table.changeset(%Table{}, attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> insert
  end

  def get_by_id(id) do
    one(from t in Table, where: t.id == ^id, preload: :todos)
  end

  def attatch_todo_to_table(table, todo) do
    todo
    |> Todos.Repo.preload(:table)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:table, table)
    |> Todos.Repo.update!()
  end
end
