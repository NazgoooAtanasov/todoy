defmodule TodosWeb.TableView do
  use TodosWeb, :view

  def render("tables.json", %{tables: tables}) do
    render_many(tables, TodosWeb.TableView, "table.json")
  end

  def render("table.json", %{table: table}) do
    table
  end

  def render("errors.json", %{errors: errors}) do
    errors
  end
end
