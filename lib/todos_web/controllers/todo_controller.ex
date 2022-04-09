defmodule TodosWeb.TodoController do
  use TodosWeb, :controller
  alias Todos.TodosManager.TodoRepo
  alias TodosWeb.Router.Helpers, as: Routes
  alias Todos.TodosManager.Todo

  def index(conn, _params) do
    todos = TodoRepo.list_todos
    render conn, "index.html", todos: todos
  end

  def new(conn, _params) do
    changeset = Todo.changeset(%Todo{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"todo" => params}) do
      case TodoRepo.create_todo(params) do
        {:ok, _todo} ->
          redirect conn, to: Routes.todo_path(conn, :index)

        {:error, changeset} ->
          render conn, "new.html", changeset: changeset
      end
  end

  def get(conn, %{"todo_id" => params}) do
    todo = TodoRepo.get_by_id(params)

    render conn, "todo.html", todo: todo
  end

  def edit(conn, %{"id" => id}) do
    todo = TodoRepo.get_by_id(id)
    changeset = Todo.changeset(todo, %{})

    render conn, "edit.html",
      changeset: changeset,
      id: todo.id
  end

  def update(conn, %{"todo" => attrs, "id" => id}) do
    todo = TodoRepo.get_by_id(id)
    case TodoRepo.update_todo(todo, attrs) do
      {:ok, _todo} ->
        redirect conn, to: Routes.todo_path(conn, :index)

      {:error, changeset} ->
        render conn, "edit.html",
          changeset: changeset,
          id: todo.id
    end
  end

  def delete(conn, %{"id" => id}) do
    case TodoRepo.delete_by_id(id) do
      {:ok, _todo} ->
        conn
        |> put_flash(:info, "Deletion successful")
        |> redirect(to: Routes.todo_path(conn, :index))

      {:error, _todo} ->
        conn
        |> put_flash(:info, "Deletion not successful")
        |> redirect(to: Routes.todo_path(conn, :index))
    end
  end
end
