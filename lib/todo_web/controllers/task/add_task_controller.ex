defmodule TodoWeb.Task.AddTaskController do
  use PhoenixSwagger
  use TodoWeb, :controller

  alias Guardian.Plug
  alias Todo.Tasks.Task
  alias TodoWeb.FallbackController
  alias TodoWeb.Task.TaskJSON

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

    response(201, "Task created", Schema.ref(:Task))
    response(401, "Unauthorized", Schema.ref(:Error))
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
