defmodule Todo.Tasks.Update do
  alias Todo.Error
  alias Todo.Tasks.Task
  alias Todo.Repo

  @spec call(map()) :: {:ok, Task.t()} | {:error, Error.t()}
  def call(%{"id" => id} = params) do
    case Repo.get(Task, id) do
      nil -> {:error, Error.build_task_not_found()}
      task -> do_update(task, params)
    end
  end

  defp do_update(task, params) do
    task
    |> Task.changeset(params)
    |> Repo.update()
  end
end
