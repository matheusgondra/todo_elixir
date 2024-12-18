defmodule TodoWeb.RedirectController do
  use TodoWeb, :controller

  def handle(conn, _params) do
    conn
    |> put_status(301)
    |> redirect(to: "/docs")
  end
end
