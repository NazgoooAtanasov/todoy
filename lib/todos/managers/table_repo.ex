defmodule Todos.TableManager.TableRepo do
  import Todos.Repo
  import Ecto.Query

  alias Todos.Table

  def list_tables, do: all(Table)

  def create_table(attrs) do
    Table.changeset(%Table{}, attrs)
    |> insert
  end

  def get_by_id(id) do
    one(from t in Table, where: t.id == ^id, preload: [:todos])
  end

  def attatch_todo_to_table(table, todo) do
    todo
    |> Todos.Repo.preload(:table)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:table, table)
    |> Todos.Repo.update!()
  end
end
