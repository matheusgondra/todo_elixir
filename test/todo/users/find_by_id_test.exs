defmodule Todo.Users.FindByIdTest do
  use Todo.DataCase

  import Todo.Factory

  alias Ecto.UUID
  alias Todo.Error
  alias Todo.Users.FindById
  alias Todo.Users.User

  describe "call/1" do
    test "return the user" do
      id = UUID.autogenerate()

      insert(:user, %{id: id})
      response = FindById.call(id)

      assert {:ok,
              %User{
                id: _,
                name: "any_name",
                password: nil,
                email: "any@mail.com",
                hashed_password: _
              }} = response
    end

    test "return error when user not found" do
      id = UUID.autogenerate()

      response = FindById.call(id)

      assert {:error, %Error{status: :not_found, result: "User not found"}} = response
    end
  end
end
