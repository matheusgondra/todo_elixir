defmodule Todo do
  @moduledoc """
  Todo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Todo.Error
  alias Todo.Tasks.Create, as: CreateTask
  alias Todo.Tasks.GetByPage
  alias Todo.Users.Create, as: UserCreate
  alias Todo.Users.User
  alias TodoWeb.Auth.Guardian

  @spec sign_up(map()) :: {:ok, User.t()} | {:error, Error.t()}
  defdelegate sign_up(params), to: UserCreate, as: :call

  @spec login(map()) :: {:ok, String.t()} | {:error, Error.t()}
  defdelegate login(params), to: Guardian, as: :authenticate

  @spec create_task(map()) :: {:ok, Task.t()} | {:error, Error.t()}
  defdelegate create_task(params), to: CreateTask, as: :call

  @spec list_tasks(pos_integer(), pos_integer()) :: list(Task.t())
  defdelegate list_tasks(page, pige_size), to: GetByPage, as: :call
end
