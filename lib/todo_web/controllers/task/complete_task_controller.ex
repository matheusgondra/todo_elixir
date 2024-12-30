defmodule TodoWeb.Task.CompleteTaskController do
  use TodoWeb, :controller

  alias TodoWeb.Task.TaskJSON
  alias TodoWeb.FallbackController

  action_fallback FallbackController

  def handle(conn, %{"id" => id}) do
    with {:ok, task} <- Todo.update_task(%{"id" => id, "completed" => true}) do
      conn
      |> put_status(:ok)
      |> put_view(TaskJSON)
      |> render(:show, task: task)
    end
  end
end
