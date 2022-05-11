defmodule Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__, :table, :table_id]}
  schema "todos" do
    field :description, :string
    field :title, :string
    belongs_to :table, Todos.Table

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
