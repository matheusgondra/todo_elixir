defmodule TodoWeb.Api.UserJSON do
  def show(%{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      created_at: user.created_at,
      updated_at: user.updated_at
    }
  end
end
