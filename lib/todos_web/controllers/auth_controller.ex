defmodule TodosWeb.AuthController do
  import Phoenix.Controller
  import Plug.Conn
  use TodosWeb, :controller

  alias Todos.UserManager
  alias Todos.User
  alias TodosWeb.Router.Helpers, as: Routes

  def create_show(conn, _params) do
    changeset = User.changeset %User{}, %{}
    render conn, "signup.html", changeset: changeset, action: Routes.auth_path(conn, :create)
  end

  def create(conn, %{"user" => params}) do
    case UserManager.create_user(params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user)
        |> put_flash(:info, "Successful register")
        |> redirect(to: Routes.todo_path(conn, :index))

      {:error, changeset} ->
        # @FIXME - If the password field is empty the form is not displayed as invalid, it just rerenders it.
        conn
        |> render("signup.html", changeset: changeset, action: Routes.auth_path(conn, :create))
    end
  end

  def login_show(conn, _params) do
    changeset = User.changeset %User{}, %{}
    render conn, "signin.html", changeset: changeset, action: Routes.auth_path(conn, :login)
  end

  # @TODO: Remove the flash messages.
  def login(conn, %{"user" => params}) do
    %{"email" => email, "password" => password} = params

    case UserManager.validate_user(%{email: email, password: password}) do
      {:ok, %Todos.User{} = user} ->
        conn
        |> put_session(:current_user, user)
        |> put_flash(:info, "Logged in!")
        |> redirect(to: Routes.todo_path(conn, :index))

      # @FIXME: Some errors are not handled!
      {:error, error_msg} ->
        conn
        |> put_flash(:error, error_msg)
        |> render("signin.html", changeset: nil, action: Routes.auth_path(conn, :login))
    end
  end

  def logout(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> redirect(to: Routes.todo_path(conn, :index))
  end
end
