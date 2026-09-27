defmodule TodoWeb.Api.Task.TaskJSON do
  def show(%{task: task}), do: data(task)

  def page(%{tasks: tasks, page: page, limit: limit}) do
    %{
      page: page,
      limit: limit,
      data: Enum.map(tasks, &data/1)
    }
  end

  defp data(task) do
    %{
      id: task.id,
      title: task.title,
      completed: task.completed,
      created_at: task.created_at,
      updated_at: task.updated_at
    }
  end
end
