defmodule TodosWeb.AuthController do
  import Phoenix.Controller
  use TodosWeb, :controller

  alias Todos.UserManager
  alias Todos.User
  alias TodosWeb.Router.Helpers, as: Routes

  def create(conn, %{"user" => params}) do
    case UserManager.create_user(params) do
      {:ok, _user} ->
        conn
        |> put_status(201)
        |> json(%{})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> render("errors.json", errors: Ecto.Changeset.traverse_errors(changeset, fn {msg, _opts} -> msg end))
    end
  end

  # @TODO: Remove the flash messages.
  # @TODO: JWT
  def login(conn, %{"user" => params}) do
    %{"email" => email, "password" => password} = params

    case UserManager.validate_user(%{email: email, password: password}) do
      {:ok, %Todos.User{} = user} ->
        {:ok, token, _claims} = Todos.Guardian.encode_and_sign(user)
        render conn, "jwt.json", token: token

      {:error, error_msg} ->
        conn
        |> put_status(401)
        |> render("errors.json", errors: %{error: error_msg})
    end
  end
end
