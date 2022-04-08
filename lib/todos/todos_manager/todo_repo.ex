defmodule Todos.TodosManager.TodoRepo do
  import Ecto.Query
  import Todos.Repo

  alias Todos.TodosManager.Todo

  def list_todos do
    all(Todo)
  end

  def get_by_id!(id) do
    one!(from t in Todo, where: t.id == ^id)
  end

  def create_todo(todo = %Todo{}) do
    changeset = get_changeset(todo)
    insert(changeset)
  end

  def update_todo(todo = %Todo{}, attrs) do
    changeset = get_changeset(todo, attrs)
    update(changeset)
  end

  def update_todo(id, attrs) do
    todo = get_by_id!(id)
    update_todo(todo, attrs)
  end

  def delete_by_id!(id) do
    todo = get_by_id!(id)
    delete!(todo)
  end

  defp get_changeset(todo = %Todo{}, attrs \\ %{}) do
    Todo.changeset(todo, attrs)
  end
end
