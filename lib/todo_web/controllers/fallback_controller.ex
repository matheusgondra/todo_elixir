defmodule TodoWeb.FallbackController do
  use TodoWeb, :controller

  alias Todo.Error
  alias TodoWeb.ErrorJSON

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorJSON)
    |> render(:error, result: result)
  end
end
