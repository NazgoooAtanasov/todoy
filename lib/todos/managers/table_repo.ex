defmodule Todos.TableManager.TableRepo do
  import Todos.Repo

  alias Todos.Table

  def create_table(attrs) do
    Table.changeset(%Table{}, attrs)
    |> insert
  end
end
