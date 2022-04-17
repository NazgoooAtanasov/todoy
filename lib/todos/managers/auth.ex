defmodule Todos.AuthManager do
  require Logger

  alias Ueberauth.Auth

  def find(%Auth{provider: :identity} = auth) do
    {:ok, auth}
  end
end
