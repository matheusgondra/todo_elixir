defmodule TodoWeb.Api.Auth.SignUpControllerTest do
  use TodoWeb.ConnCase, async: true

  import Todo.Factory

  alias Todo.Users.User
  alias Todo.Repo

  describe "handle/2" do
    test "returns a user on success", %{conn: conn} do
      params = build(:user_params)

      conn = post(conn, ~p"/api/signup", params)

      assert %{
               "id" => id,
               "name" => "any_name",
               "email" => "any@mail.com",
               "created_at" => _,
               "updated_at" => _
             } = json_response(conn, 201)

      user = Repo.get!(User, id)

      assert %User{id: ^id, name: "any_name", email: "any@mail.com"} = user
    end

    test "returns an error on failure", %{conn: conn} do
      params = build(:user_params, %{"email" => "invalid_email"})

      conn = post(conn, ~p"/api/signup", params)

      assert %{
               "message" => %{
                 "email" => ["has invalid format"]
               }
             } = json_response(conn, 400)
    end
  end
end
