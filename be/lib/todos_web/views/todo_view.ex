defmodule TodosWeb.TodoView do
  use TodosWeb, :view

  def render("todos.json", %{todos: todos}) do
    render_many(todos, TodosWeb.TodoView, "todo.json")
  end

  def render("todo.json", %{todo: todo}) do
    %{
      id: todo.id,
      name: todo.title,
      description: todo.description,
      tableId: todo.table_id,
      userId: todo.user_id
    }
  end

  def render("errors.json", %{errors: errors}) do
    errors
  end
end
