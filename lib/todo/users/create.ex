defmodule Todo.Users.Create do
  alias Todo.Error
  alias Todo.Repo
  alias Todo.Users.User

  @spec call(map()) :: {:ok, User.t()} | {:error, Error.t()}
  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{} = user}), do: {:ok, user}
  defp handle_insert({:error, changeset}), do: {:error, Error.build(:bad_request, changeset)}
end
