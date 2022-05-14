defmodule TodosWeb.TodoController do
  use TodosWeb, :controller
  alias Todos.TodosManager.TodoRepo

  def index(conn, _params) do
    todos = TodoRepo.list_todos
    render conn, "todos.json", todos: todos
  end

  def create(conn, %{"todo" => params}) do
      case TodoRepo.create_todo(params) do
        {:ok, todo} ->
          render conn, "todo.json", todo: todo 

        {:error, changeset} ->
          conn
          |> put_status(400)
          |> render("errors.json", errors: Ecto.Changeset.traverse_errors(changeset, fn {msg, _opts} -> msg end))
      end
  end

  def get(conn, %{"id" => params}) do
    todo = TodoRepo.get_by_id(params)

    render conn, "todo.json", todo: todo
  end

  def update(conn, %{"todo" => attrs, "id" => id}) do
    todo = TodoRepo.get_by_id(id)
    case TodoRepo.update_todo(todo, attrs) do
      {:ok, todo} ->
        render conn, "todo.json", todo: todo

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render("errors.json", errors: Ecto.Changeset.traverse_errors(changeset, fn {msg, _opts} -> msg end))
    end
  end

  def delete(conn, %{"id" => id}) do
    case TodoRepo.delete_by_id(id) do
      {:ok, todo} ->
        conn
        |> render("todo.json", todo: todo)

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render("errors.json", errors: Ecto.Changeset.traverse_errors(changeset, fn {msg, _opts} -> msg end))
    end
  end
end
