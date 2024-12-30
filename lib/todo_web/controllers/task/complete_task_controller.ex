defmodule TodoWeb.Task.CompleteTaskController do
  use PhoenixSwagger
  use TodoWeb, :controller

  alias TodoWeb.FallbackController
  alias TodoWeb.Task.TaskJSON

  action_fallback FallbackController

  swagger_path :handle do
    patch("/tasks/:id/complete")
    summary("Complete a task")
    description("Complete a task")
    tag("Tasks")
    security([%{Bearer: []}])

    response(200, "Task completed", Schema.ref(:Task))
    response(401, "Unauthorized", Schema.ref(:Error))
    response(404, "Task not found", Schema.ref(:Error))
  end

  def handle(conn, %{"id" => id}) do
    with {:ok, task} <- Todo.update_task(%{"id" => id, "completed" => true}) do
      conn
      |> put_status(:ok)
      |> put_view(TaskJSON)
      |> render(:show, task: task)
    end
  end
end
