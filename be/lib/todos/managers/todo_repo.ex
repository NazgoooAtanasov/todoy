defmodule Todos.TodosManager.TodoRepo do
  import Ecto.Query
  import Todos.Repo

  alias Todos.Todo

  def list_todos do
    all(Todo)
    |> Todos.Repo.preload(:table)
  end

  def list_unassigned_todos do
    all(from t in Todo, where: is_nil(t.table_id))
  end

  def get_by_id(id) do
    # TODO(n): Check for error!
    one(from t in Todo, where: t.id == ^id)
  end

  def create_todo(attrs, user) do
    get_changeset(%Todo{}, attrs)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:user, user)
    |> insert()
  end

  def update_todo(todo = %Todo{}, attrs) do
    changeset = get_changeset(todo, attrs)
    update(changeset)
  end

  def update_todo(id, attrs) do
    todo = get_by_id(id)
    update_todo(todo, attrs)
  end

  def delete_by_id(id) do
    todo = get_by_id(id)
    delete(todo)
  end

  defp get_changeset(todo = %Todo{}, attrs) do
    Todo.changeset(todo, attrs)
  end
end
