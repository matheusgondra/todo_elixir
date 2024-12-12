defmodule Todo.ErrorTest do
  use ExUnit.Case, async: true

  alias Todo.Error

  describe "build/2" do
    test "returns a struct with the given status and result" do
      response = Error.build(:bad_request, "Invalid request")

      expected_response = %Error{status: :bad_request, result: "Invalid request"}

      assert response == expected_response
    end
  end

  describe "build_user_not_found/0" do
    test "returns a struct with status :not_found and result 'User not found'" do
      response = Error.build_user_not_found()

      expected_response = %Error{status: :not_found, result: "User not found"}

      assert response == expected_response
    end
  end
end
