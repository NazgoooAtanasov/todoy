defmodule Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  # @TODO: remove the :table, :table_id from exlusion. find a way to preload properly.
  @derive {Jason.Encoder, except: [:__meta__]}
  schema "todos" do
    field :description, :string
    field :title, :string
    belongs_to :table, Todos.Table
    belongs_to :user, Todos.User

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
