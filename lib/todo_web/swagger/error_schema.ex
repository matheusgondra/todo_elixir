defmodule TodoWeb.Swagger.ErrorSchema do
  @moduledoc """
  Defines Swagger schemas for error responses.
  """
  use PhoenixSwagger

  @doc """
  The error schema
  """
  def error_schema do
    swagger_schema do
      title("ErrorResponse")
      description("An error response from the API")

      properties do
        message(:string, "A message describing the error")
      end

      example(error_example())
    end
  end

  @doc """
  An example error response
  """
  def error_example(error \\ "Invalid Credentials") do
    %{
      message: error
    }
  end
end
