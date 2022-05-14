defmodule TodosWeb.TableView do
  use TodosWeb, :view

  def render("tables.json", %{tables: tables}) do
    render_many(tables, TodosWeb.TableView, "table.json")
  end

  def render("table.json", %{table: table}) do
    %{
      table: %{
        id: table.id,
        name: table.description,
        description: table.description
      },
      todos: render_many(table.todos, TodosWeb.TodoView, "todo.json")
    }
  end

  def render("errors.json", %{errors: errors}) do
    errors
  end
end
