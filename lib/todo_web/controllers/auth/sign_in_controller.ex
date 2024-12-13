defmodule TodoWeb.Auth.SignInController do
  use TodoWeb, :controller
  use PhoenixSwagger

  alias TodoWeb.Swagger.AuthSchema
  alias TodoWeb.Swagger.ErrorSchema
  alias TodoWeb.FallbackController

  action_fallback FallbackController

  swagger_path :handle do
    post("/signin")
    description("Sign in a user")
    tag("Auth")

    parameters do
      body(:body, Schema.ref(:SignInParams), "User credentials", required: true)
    end

    response(200, "User signed in", Schema.ref(:SignIn), example: AuthSchema.sign_in_example())
    response(401, "Unauthorized", Schema.ref(:Error), example: ErrorSchema.error_example())
  end

  def handle(conn, params) do
    with {:ok, token} <- Todo.login(params) do
      conn
      |> put_status(:ok)
      |> json(%{access_token: token})
    end
  end
end
