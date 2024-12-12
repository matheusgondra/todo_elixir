defmodule TodoWeb.User.UserJsonTest do
  use TodoWeb.ConnCase, async: true

  import Todo.Factory

  alias TodoWeb.UserJSON

  describe "show/1" do
    test "returns a user" do
      user = build(:user)

      response = UserJSON.show(%{user: user})

      expected_response = %{
        id: user.id,
        name: "any_name",
        email: "any@mail.com",
        created_at: user.created_at,
        updated_at: user.updated_at
      }

      assert response == expected_response
    end
  end
end
