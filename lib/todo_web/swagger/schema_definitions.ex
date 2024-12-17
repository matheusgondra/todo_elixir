defmodule TodoWeb.Swagger.SchemaDefinitions do
  @moduledoc """
  Defines Swagger schemas for API documentation.
  """

  use PhoenixSwagger

  alias TodoWeb.Swagger.AuthSchema
  alias TodoWeb.Swagger.ErrorSchema
  alias TodoWeb.Swagger.TaskSchema
  alias TodoWeb.Swagger.UserSchema

  @doc """
  Defines the schemas for the API documentation.
  """
  def definitions do
    %{
      User: UserSchema.user_schema(),
      UserParams: UserSchema.user_params_schema(),
      Error: ErrorSchema.error_schema(),
      SignIn: AuthSchema.sign_in_schema(),
      SignInParams: AuthSchema.sign_in_params_schema(),
      Task: TaskSchema.task_schema(),
      TaskParams: TaskSchema.task_params_schema(),
      TaskList: TaskSchema.task_list_schema()
    }
  end
end
