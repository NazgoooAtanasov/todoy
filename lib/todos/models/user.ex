defmodule Todos.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_email()
    |> validate_password()
  end

  defp validate_email(changeset) do
    changeset
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/\w+@\w+.\w{2,4}/)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_length(:password, min: 8)
  end
end
