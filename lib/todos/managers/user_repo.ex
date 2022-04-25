defmodule Todos.UserManager do
  import Ecto.Changeset
  import Todos.Repo
  import Ecto.Query
  alias Todos.User

  def find_user(email) do
    one(from u in User, where: u.email == ^email)
  end

  def create_user(attrs) do
    changeset = User.changeset(%User{}, attrs)

    if changeset.valid? do
      %{ password_hash: hash } = hash_password changeset

      changeset = changeset
        |> put_change(:password_hash, hash)

      case insert(changeset) do
        {:ok, info} -> {:ok, info}
        {:error, info} -> {:error, info}
      end
    else
      {:error, changeset}
    end
  end

  def validate_user(%{email: email, password: pass } = _attrs) do
    case find_user(email) do
      user when is_nil(user) == false ->
        Bcrypt.check_pass(user, pass)
      _ ->
      {:error, "User not found"}
    end
  end

  defp hash_password(changeset) do
    password = changeset
      |> get_field(:password)

    Bcrypt.add_hash(password)
  end
end
