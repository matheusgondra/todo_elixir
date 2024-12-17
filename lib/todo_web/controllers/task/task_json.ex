defmodule TodoWeb.Task.TaskJSON do
  def show(%{task: task}) do
    %{
      id: task.id,
      title: task.title,
      created_at: task.created_at,
      updated_at: task.updated_at
    }
  end
end
