defmodule TodoWeb.Swagger.SchemaDefinitions do
  @moduledoc """
  Defines Swagger schemas for API documentation.
  """

  use PhoenixSwagger

  alias TodoWeb.Swagger.ErrorSchema
  alias TodoWeb.Swagger.UserSchema

  def definitions do
    %{
      User: UserSchema.user_schema(),
      UserParams: UserSchema.user_params_schema(),
      Error: ErrorSchema.error_schema()
    }
  end
end
