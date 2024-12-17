defmodule TodoWeb.Swagger.TaskSchema do
  @moduledoc """
  Task schema for Swagger documentation
  """
  use PhoenixSwagger

  @doc "The task schema"
  def task_schema do
    swagger_schema do
      title("Task")
      description("A task in the application")

      properties do
        id(:string, "Unique identifier for the task")
        title(:string, "The task's title")
        created_at(:string, "The date and time the task was created")
        updated_at(:string, "The date and time the task was last updated")
      end

      example(task_example())
    end
  end

  @doc "An example task for use in documentation"
  def task_example do
    %{
      id: "0bf45eb1-e00c-41d6-8fa3-0bcf85802823",
      title: "Buy groceries",
      created_at: "2021-08-01T12:00:00Z",
      updated_at: "2021-08-01T12:00:00Z"
    }
  end

  @doc "The task params schema"
  def task_params_schema do
    swagger_schema do
      title("TaskParams")
      description("Parameters for creating a task")

      properties do
        title(:string, "Task title", required: true)
      end
    end
  end
end
