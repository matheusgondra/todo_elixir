defmodule TodoWeb.Swagger.UserSchema do
  @moduledoc "User schema for Swagger documentation"
  use PhoenixSwagger

  @doc "The user schema"
  def user_schema do
    swagger_schema do
      title("User")
      description("A user of the application")

      properties do
        id(:string, "Unique identifier for the user")
        name(:string, "The user's name")
        email(:string, "The user's email address")
        created_at(:string, "The date and time the user was created")
        updated_at(:string, "The date and time the user was last updated")
      end

      example(user_example())
    end
  end

  @doc "An example user for use in documentation"
  def user_example do
    %{
      id: "0bf45eb1-e00c-41d6-8fa3-0bcf85802823",
      name: "Alice",
      email: "alice@mail.com",
      created_at: "2021-08-01T12:00:00Z",
      updated_at: "2021-08-01T12:00:00Z"
    }
  end

  @doc "The user params schema"
  def user_params_schema do
    swagger_schema do
      title("UserParams")
      description("Parameters for creating a user")

      properties do
        name(:string, "User name", required: true)
        email(:string, "User email address", required: true)
        password(:string, "User password", required: true)
      end
    end
  end
end
