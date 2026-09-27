defmodule Todo.Users.CreateTest do
  use Todo.DataCase

  import Todo.Factory

  alias Todo.Error
  alias Todo.Users.Create
  alias Todo.Users.User

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      result = Create.call(params)

      assert {:ok, %User{}} = result
    end

    test "when there are invalid params, return an error" do
      params = build(:user_params, %{"name" => nil})

      response = Create.call(params)

      expected_response = %{
        name: ["can't be blank"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
