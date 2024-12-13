defmodule TodoWeb.Router do
  use TodoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TodoWeb.Auth do
    pipe_through :api

    post "/signup", SignUpController, :handle
    post "/signin", SignInController, :handle
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "TODO API"
      },
      basePath: "/api",
      consumes: ["application/json"],
      produces: ["application/json"]
    }
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:todo, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TodoWeb.Telemetry
    end
  end
end