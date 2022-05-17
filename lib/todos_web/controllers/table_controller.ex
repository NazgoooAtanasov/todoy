defmodule TodosWeb.TableController do
  use TodosWeb, :controller
  alias Todos.TableManager.TableRepo
  alias Todos.TodosManager.TodoRepo

  def index(conn, _args) do
    tables = TableRepo.list_tables()
    render conn, "tables.json", tables: tables
  end

  def create(conn, %{"table" => table}) do
    case TableRepo.create_table(table, conn.assigns[:user]) do
      {:ok, result} ->
        conn
        |> render("table.json", table: result)

      {:error, changeset} ->
        conn
        |> put_status(401)
        |> render("errors.json", errors: Ecto.Changeset.traverse_errors(changeset, fn {msg, _opts} -> msg end))
    end
  end

  def get(conn, %{"id" => id}) do
    case TableRepo.get_by_id(id) do
      table when is_nil(table) == false ->
        render conn, "table.json", table: table

      _ ->
        conn
        |> put_status(404)
        |> json(%{})
    end
  end

  def add_todo(conn, %{"table_id" => table_id, "todo_id" => todo_id}) do
    todo = TodoRepo.get_by_id(todo_id)
    table = TableRepo.get_by_id(table_id)
    TableRepo.attatch_todo_to_table(table, todo)

    json conn, %{}
  end
end
