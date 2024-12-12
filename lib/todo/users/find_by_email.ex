defmodule Todo.Users.FindByEmail do
  alias Todo.Error
  alias Todo.Users.User
  alias Todo.Repo

  @spec call(String.t()) :: {:ok, User.t()} | {:error, Error.t()}
  def call(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, Error.build_user_not_found()}
      user -> {:ok, user}
    end
  end
end
