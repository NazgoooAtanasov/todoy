defmodule Todos.Table do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tables" do
    field :title, :string
    field :description, :string
    has_many :todos, Todos.Todo

    timestamps()
  end

  @doc false
  def changeset(table, attrs) do
    table
    |> cast(attrs, [:title, :description])
    |> validate_required([:title])
  end
end
