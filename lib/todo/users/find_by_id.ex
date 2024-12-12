defmodule Todo.Users.FindById do
  alias Todo.Error
  alias Todo.Repo
  alias Todo.Users.User

  @spec call(String.t()) :: {:ok, User.t()} | {:error, Error.t()}
  def call(id) do
    case Repo.get_by(User, id: id) do
      nil -> {:error, Error.build_user_not_found()}
      user -> {:ok, user}
    end
  end
end
