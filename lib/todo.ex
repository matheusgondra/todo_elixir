defmodule Todo do
  @moduledoc """
  Todo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Todo.Error
  alias Todo.Users.Create, as: UserCreate
  alias Todo.Users.User
  alias TodoWeb.Auth.Guardian

  @spec sign_up(map()) :: {:ok, User.t()} | {:error, Error.t()}
  defdelegate sign_up(params), to: UserCreate, as: :call

  @spec login(map()) :: {:ok, String.t()} | {:error, Error.t()}
  defdelegate login(params), to: Guardian, as: :authenticate
end
