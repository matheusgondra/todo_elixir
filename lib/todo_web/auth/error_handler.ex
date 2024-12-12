defmodule TodoWeb.Auth.ErrorHandler do
  @behaviour Guardian.Plug.ErrorHandler

  alias Plug.Conn

  @impl true
  def auth_error(conn, {error, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(error)})

    Conn.send_resp(conn, 401, body)
  end
end
