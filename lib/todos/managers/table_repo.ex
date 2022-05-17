defmodule Todos.TableManager.TableRepo do
  import Todos.Repo
  import Ecto.Query

  alias Todos.Table

  def list_tables(%Todos.User{} = user), do: 
    all(from t in Table, where: t.user_id == ^user.id) 
    |> Todos.Repo.preload(:todos)

  def create_table(attrs, user) do
    changeset = Table.changeset(%Table{}, attrs)

    if changeset.valid? do
      table = changeset
      |> Ecto.Changeset.put_assoc(:user, user)
      |> insert!
      |> Todos.Repo.preload(:todos)

      {:ok, table}
    else
      {:error, changeset}
    end
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
