defmodule TodoWeb.Task.CompleteTaskController do
  use PhoenixSwagger
  use TodoWeb, :controller

  alias TodoWeb.FallbackController
  alias TodoWeb.Swagger.TaskSchema
  alias TodoWeb.Swagger.ErrorSchema
  alias TodoWeb.Task.TaskJSON

  action_fallback FallbackController

  swagger_path :handle do
    patch("/tasks/{id}/complete")
    summary("Complete a task")
    description("Complete a task")
    tag("Tasks")
    security([%{Bearer: []}])

    parameter(:id, :path, :string, "Task ID", required: true)

    response(200, "Task completed", Schema.ref(:Task), example: TaskSchema.task_example())
    response(401, "Unauthorized", Schema.ref(:Error), example: ErrorSchema.error_example())

    response(404, "Task not found", Schema.ref(:Error),
      example: ErrorSchema.error_example("Task not found")
    )
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
