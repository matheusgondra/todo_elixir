defmodule Todo.Users.UserTest do
  use Todo.DataCase

  import Todo.Factory

  alias Ecto.Changeset
  alias Todo.Users.User

  describe "changeset/1" do
    test "with valid attributes" do
      params = build(:user_params)
      response = User.changeset(params)

      assert %Changeset{changes: %{name: "any_name"}, valid?: true} = response
    end

    test "with invalid attributes" do
      params =
        build(:user_params, %{"email" => "invalid_email"})

      response = User.changeset(params)

      expected_response = %{email: ["has invalid format"]}

      assert errors_on(response) == expected_response
    end
  end
end
