defmodule Todos.Guardian do
  use Guardian, otp_app: :todos

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _), do: {:error, :reason}

  def resource_from_claims(%{"sub" => id}) do
    user = Todos.UserManager.find_user(id, :id)
    {:ok, user}
  end

  def resource_from_claims(_claims), do: {:error, :reason}
end
