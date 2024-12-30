defmodule TodoWeb.Task.UpdateTitleTaskController do
  use TodoWeb, :controller

  alias TodoWeb.FallbackController
  alias TodoWeb.Task.TaskJSON

  action_fallback FallbackController

  def handle(conn, params) do
    with {:ok, task} <- Todo.update_task(params) do
      conn
      |> put_status(:ok)
      |> put_view(TaskJSON)
      |> render(:show, task: task)
    end
  end
end
