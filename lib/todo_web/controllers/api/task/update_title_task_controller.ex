defmodule TodoWeb.Task.UpdateTitleTaskController do
  use PhoenixSwagger
  use TodoWeb, :controller

  alias TodoWeb.FallbackController
  alias TodoWeb.Swagger.ErrorSchema
  alias TodoWeb.Swagger.TaskSchema
  alias TodoWeb.Task.TaskJSON

  action_fallback FallbackController

  swagger_path :handle do
    patch("/tasks/{id}")
    summary("Update a task title")
    description("Update a task title")
    tag("Tasks")
    security([%{Bearer: []}])

    parameter(:id, :path, :string, "Task ID", required: true)

    parameters do
      body(:body, Schema.ref(:TaskParams), "Task details", required: true)
    end

    response(200, "Task updated", Schema.ref(:Task), example: TaskSchema.task_example())
    response(401, "Unauthorized", Schema.ref(:Error), example: ErrorSchema.error_example())

    response(404, "Task not found", Schema.ref(:Error),
      example: ErrorSchema.error_example("Task not found")
    )
  end

  def handle(conn, params) do
    with {:ok, task} <- Todo.update_task(params) do
      conn
      |> put_status(:ok)
      |> put_view(TaskJSON)
      |> render(:show, task: task)
    end
  end
end
