defmodule Todo.Factory do
  use ExMachina.Ecto, repo: Todo.Repo

  alias Todo.Users.User

  def user_factory do
    %User{
      id: Ecto.UUID.generate(),
      name: "any_name",
      email: "any@mail.com",
      password: "any_password",
      hashed_password: "any_password_hash",
      created_at: NaiveDateTime.utc_now(),
      updated_at: NaiveDateTime.utc_now()
    }
  end

  def user_params_factory do
    %{
      "name" => "any_name",
      "email" => "any@mail.com",
      "password" => "any_password"
    }
  end

  def user_login_params_factory do
    %{
      "email" => "any@mail.com",
      "password" => "any_password"
    }
  end
end
