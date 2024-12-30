defmodule TodoWeb.Auth.SignUpController do
  use PhoenixSwagger
  use TodoWeb, :controller

  alias TodoWeb.FallbackController
  alias TodoWeb.UserJSON

  action_fallback FallbackController

  swagger_path :handle do
    post("/signup")
    summary("Sign up a new user")
    description("Sign up a new user")
    tag("Auth")

    parameters do
      body(:body, Schema.ref(:UserParams), "User parameters", required: true)
    end

    response(201, "User created", Schema.ref(:User))
    response(400, "Bad request", Schema.ref(:Error))
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
