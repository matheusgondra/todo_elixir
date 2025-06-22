defmodule TodoWeb.Api.Auth.SignInControllerTest do
  use TodoWeb.ConnCase, async: true

  import Todo.Factory

  alias Todo.Users.User
  alias Todo.Repo

  describe "handle/2" do
    test "returns a token when the user is authenticated", %{conn: conn} do
      {:ok, _} =
        build(:user_params)
        |> User.changeset()
        |> Repo.insert()

      params = build(:user_login_params)

      response =
        conn
        |> post(~p"/api/signin", params)
        |> json_response(:ok)

      assert %{"access_token" => _} = response
    end

    test "returns an error when the user is not authenticated", %{conn: conn} do
      params = build(:user_login_params)

      response =
        conn
        |> post(~p"/api/signin", params)
        |> json_response(:unauthorized)

      assert %{"message" => "Invalid credentials"} = response
    end
  end
end
