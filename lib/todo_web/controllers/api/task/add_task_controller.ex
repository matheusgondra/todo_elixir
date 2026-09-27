defmodule TodoWeb.Api.Task.AddTaskController do
  use TodoWeb, :controller
  use PhoenixSwagger

  alias Guardian.Plug
  alias Todo.Tasks.Task
  alias TodoWeb.Api.Task.TaskJSON
  alias TodoWeb.FallbackController
  alias TodoWeb.Swagger.ErrorSchema
  alias TodoWeb.Swagger.TaskSchema

  action_fallback FallbackController

  swagger_path :handle do
    post("/tasks")
    summary("Create a task")
    description("Create a task")
    tag("Tasks")
    security([%{Bearer: []}])

    parameters do
      body(:body, Schema.ref(:TaskParams), "Task details", required: true)
    end

    response(201, "Task created", Schema.ref(:Task), example: TaskSchema.task_example())
    response(401, "Unauthorized", Schema.ref(:Error), example: ErrorSchema.error_example())
  end

  def handle(conn, params) do
    with user <- Plug.current_resource(conn),
         {:ok, %Task{} = task} <- Todo.create_task(Map.put(params, "user_id", user.id)) do
      conn
      |> put_status(:created)
      |> put_view(TaskJSON)
      |> render(:show, task: task)
    end
  end
end
