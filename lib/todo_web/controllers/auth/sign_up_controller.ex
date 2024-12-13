defmodule TodoWeb.Auth.SignUpController do
  use TodoWeb, :controller
  use PhoenixSwagger

  alias TodoWeb.FallbackController
  alias TodoWeb.Swagger.ErrorSchema
  alias TodoWeb.Swagger.UserSchema
  alias TodoWeb.UserJSON

  action_fallback FallbackController

  swagger_path :handle do
    post("/signup")
    description("Sign up a new user")
    tag("Auth")

    parameters do
      body(:body, Schema.ref(:UserParams), "User parameters", required: true)
    end

    response(201, "User created", Schema.ref(:User), example: UserSchema.user_example())
    response(400, "Bad request", Schema.ref(:Error), example: ErrorSchema.error_example())
  end

  def handle(conn, params) do
    with {:ok, user} <- Todo.sign_up(params) do
      conn
      |> put_status(:created)
      |> put_view(UserJSON)
      |> render(:show, user: user)
    end
  end
end
