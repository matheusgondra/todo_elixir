defmodule Todo.Users.FindByEmailTest do
  use Todo.DataCase

  import Todo.Factory

  alias Todo.Error
  alias Todo.Users.FindByEmail
  alias Todo.Users.User

  describe "call/1" do
    test "return the user" do
      email = "any@mail.com"

      insert(:user, %{email: email})
      response = FindByEmail.call(email)

      assert {:ok,
              %User{
                id: _id,
                name: "any_name",
                email: "any@mail.com",
                password: nil,
                hashed_password: _,
                created_at: _,
                updated_at: _
              }} = response
    end

    test "return error when user not found" do
      email = "any@mail.com"
      response = FindByEmail.call(email)

      assert {:error, %Error{status: :not_found, result: "User not found"}} = response
    end
  end
end
