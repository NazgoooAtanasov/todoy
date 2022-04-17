defmodule TodosWeb.AuthController do
  use TodosWeb, :controller

  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Todos.AuthManager.find(auth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Login")
        |> put_session(:current_user, user)
        |> redirect(to: "/tables")
    end
  end

  def callback(%{assigns: %{ueberauth_failure: fails}} = conn, _params) do
    conn
    |> put_flash(:info, fails)
    |> json(%{wtf: :true, fails: fails})
  end
end
