defmodule TodosWeb.TodoController do
  use TodosWeb, :controller
  alias Todos.TodosManager.TodoRepo

  def index(conn, _params) do
    todos = TodoRepo.list_todos
    render(conn, "index.html", todos: todos)
  end
end
