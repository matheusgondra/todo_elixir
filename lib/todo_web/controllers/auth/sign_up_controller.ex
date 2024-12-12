defmodule TodoWeb.Auth.SignUpController do
  use TodoWeb, :controller

  alias TodoWeb.FallbackController
  alias TodoWeb.UserJSON

  action_fallback FallbackController

  def handle(conn, params) do
    with {:ok, user} <- Todo.sign_up(params) do
      conn
      |> put_status(:created)
      |> put_view(UserJSON)
      |> render(:show, user: user)
    end
  end
end
