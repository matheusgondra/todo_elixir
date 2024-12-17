defmodule TodoWeb.Task.AddTaskController do
  use TodoWeb, :controller

  alias Guardian.Plug
  alias Todo.Tasks.Task
  alias TodoWeb.FallbackController
  alias TodoWeb.Task.TaskJSON

  action_fallback FallbackController

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
