defmodule Todo do
  @moduledoc """
  The Todo module is a facade that provides a single entry point to the
  """
  alias Todo.Error
  alias Todo.Tasks.Create, as: CreateTask
  alias Todo.Tasks.GetByPage
  alias Todo.Tasks.Update, as: UpdateTask
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
  defdelegate list_tasks(page, page_size), to: GetByPage, as: :call

  @spec update_task(map()) :: {:ok, Task.t()} | {:error, Error.t()}
  defdelegate update_task(params), to: UpdateTask, as: :call
end
