defmodule TodosWeb.AuthView do
  use TodosWeb, :view

  def render("errors.json", %{errors: errors}), do: errors

  def render("jwt.json", %{token: token}), do: %{jwt: token}
end
