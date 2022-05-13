defmodule Todos.Table do
  use Ecto.Schema
  import Ecto.Changeset

  # remove the :todos from exlusion. find a way to preload properly.
  @derive {Jason.Encoder, except: [:__meta__, :todos]}
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
