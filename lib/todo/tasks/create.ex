defmodule Todo.Tasks.Create do
  alias Todo.Error
  alias Todo.Repo
  alias Todo.Tasks.Task

  @spec call(map()) :: {:ok, Task.t()} | {:error, Error.t()}
  def call(params) do
    params
    |> Task.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  @spec handle_insert(tuple()) :: {:ok, Task.t()} | {:error, Error.t()}
  defp handle_insert({:ok, task}), do: {:ok, task}
  defp handle_insert({:error, changeset}), do: {:error, Error.build(:bad_request, changeset)}
end
