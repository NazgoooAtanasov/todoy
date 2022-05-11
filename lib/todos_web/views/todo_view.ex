defmodule TodosWeb.TodoView do
  use TodosWeb, :view

  def render("index.json", %{todos: todos}) do
    render_many(todos, TodosWeb.TodoView, "todo.json")
  end

  def render("todo.json", %{todo: todo}) do
    todo
  end

  def render("errors.json", %{errors: errors}) do
    errors
  end
end
