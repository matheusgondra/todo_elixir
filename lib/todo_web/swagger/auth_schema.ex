defmodule TodoWeb.Swagger.AuthSchema do
  @moduledoc """
  Auth schema for Swagger documentation
  """

  use PhoenixSwagger

  @doc "The auth schema"
  def sign_in_schema do
    swagger_schema do
      title("SignIn")
      description("Sign in a user")

      properties do
        access_token(:string, "Access token")
      end

      example(sign_in_example())
    end
  end

  def sign_in_example do
    %{
      access_token: "token"
    }
  end

  def sign_in_params_schema do
    swagger_schema do
      title("SignInParams")
      description("Sign in parameters")

      properties do
        email(:string, "User email", format: "email", required: true)
        password(:string, "User password", required: true)
      end

      example(%{
        email: "johndoe@mail.com",
        password: "password"
      })
    end
  end
end
