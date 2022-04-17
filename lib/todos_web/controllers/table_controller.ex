defmodule TodosWeb.TableController do
  use TodosWeb, :controller
  alias Todos.Table
  alias Todos.TableManager.TableRepo
  alias Todos.TodosManager.TodoRepo
  alias TodosWeb.Router.Helpers, as: Routes

  def index(conn, _args) do
    tables = TableRepo.list_tables()

    conn
    |> render("index.html", tables: tables)
  end

  def new(conn, _args) do
    changeset = Table.changeset(%Table{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"table" => table}) do
    case TableRepo.create_table(table) do
      {:ok, _result} ->
        redirect conn, to: Routes.table_path(conn, :index)

      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    table = TableRepo.get_by_id(id)

    render conn, "table.html", table: table
  end

  def edit(conn, %{"id" => id}) do
    table = TableRepo.get_by_id(id)
    changeset = Table.changeset(table, %{})
    todos = TodoRepo.list_unassigned_todos

    render conn, "edit.html",
      changeset: changeset, table_id: table.id, todos: todos
  end

  def add_todo(conn, %{"table_id" => table_id, "todo_id" => todo_id}) do
    todo = TodoRepo.get_by_id(todo_id)
    table = TableRepo.get_by_id(table_id)
    TableRepo.attatch_todo_to_table(table, todo)

    redirect conn, to: Routes.table_path(conn, :edit, table.id)
  end
end
