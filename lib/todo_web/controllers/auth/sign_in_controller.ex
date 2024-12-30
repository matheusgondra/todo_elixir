defmodule TodoWeb.Auth.SignInController do
  use PhoenixSwagger
  use TodoWeb, :controller

  alias TodoWeb.FallbackController

  action_fallback FallbackController

  swagger_path :handle do
    post("/signin")
    summary("Sign in a user")
    description("Sign in a user")
    tag("Auth")

    parameters do
      body(:body, Schema.ref(:SignInParams), "User credentials", required: true)
    end

    response(200, "User signed in", Schema.ref(:SignIn))
    response(401, "Unauthorized", Schema.ref(:Error))
  end

  def handle(conn, params) do
    with {:ok, token} <- Todo.login(params) do
      conn
      |> put_status(:ok)
      |> json(%{access_token: token})
    end
  end
end
