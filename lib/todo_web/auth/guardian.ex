defmodule TodoWeb.Auth.Guardian do
  use Guardian, otp_app: :todo

  alias Todo.Error
  alias Todo.Users.User
  alias Todo.Users.FindByEmail
  alias Todo.Users.FindById

  @impl true
  def subject_for_token(%{id: id}, _claims), do: {:ok, id}

  @impl true
  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> FindById.call()
  end

  @spec authenticate(map()) :: {:ok, String.t()} | {:error, Error.t()}
  def authenticate(%{"email" => email, "password" => password}) do
    with {:ok, %User{hashed_password: hash} = user} <- FindByEmail.call(email),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user, %{}, ttl: {2, :hour}) do
      {:ok, token}
    else
      _ -> {:error, Error.build(:unauthorized, "Invalid credentials")}
    end
  end
end
