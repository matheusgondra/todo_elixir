defmodule TodoWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :todo,
    module: TodoWeb.Auth.Guardian,
    error_handler: TodoWeb.Auth.ErrorHandler

  alias Guardian.Plug

  plug Plug.VerifyHeader
  plug Plug.EnsureAuthenticated
  plug Plug.LoadResource
end
