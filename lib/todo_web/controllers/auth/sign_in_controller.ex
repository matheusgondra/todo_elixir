defmodule TodoWeb.Auth.SignInController do
  use TodoWeb, :controller

  alias TodoWeb.FallbackController

  action_fallback FallbackController

  def handle(conn, params) do
    with {:ok, token} <- Todo.login(params) do
      conn
      |> put_status(:ok)
      |> json(%{access_token: token})
    end
  end
end
