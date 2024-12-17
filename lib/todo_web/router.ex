defmodule TodoWeb.Router do
  use TodoWeb, :router

  alias TodoWeb.Swagger.SchemaDefinitions

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug TodoWeb.Auth.Pipeline
  end

  scope "/api", TodoWeb.Auth do
    pipe_through :api

    post "/signup", SignUpController, :handle
    post "/signin", SignInController, :handle
  end

  scope "/api", TodoWeb do
    pipe_through [:api, :auth]

    post "/tasks", Task.AddTaskController, :handle
  end

  scope "/docs" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :todo,
      swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "TODO API"
      },
      basePath: "/api",
      consumes: ["application/json"],
      produces: ["application/json"],
      definitions: SchemaDefinitions.definitions(),
      securityDefinitions: %{
        Bearer: %{
          type: "apiKey",
          name: "Authorization",
          in: "header",
          description: "JWT Token"
        }
      }
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
