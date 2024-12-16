defmodule Todo.Tasks.CreateTest do
  alias Todo.Error
  alias Todo.Tasks.Task
  alias Todo.Tasks.Create
  use Todo.DataCase, async: true

  import Todo.Factory

  describe "call/1" do
    test "creates a task" do
      user = insert(:user, %{}, returning: true)
      user_id = user.id

      params = build(:task_params, %{"user_id" => user_id})

      response = Create.call(params)

      assert {:ok, %Task{title: "any_title", user_id: ^user_id}} = response
    end

    test "returns an error when the params is invalid" do
      user = insert(:user, %{}, returning: true)
      user_id = user.id

      params = build(:task_params, %{"user_id" => user_id, "title" => nil})

      response = Create.call(params)

      assert {:error, %Error{status: :bad_request}} = response
    end
  end
end
