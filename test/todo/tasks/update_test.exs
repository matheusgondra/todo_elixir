defmodule Todo.Tasks.UpdateTest do
  use Todo.DataCase, async: true

  import Todo.Factory

  alias Ecto.UUID
  alias Todo.Error
  alias Todo.Tasks.Task
  alias Todo.Tasks.Update

  describe "call/1" do
    test "returns an error when the task is not found" do
      response = Update.call(%{"id" => UUID.generate()})

      expected_response = {:error, %Error{status: :not_found, result: "Task not found"}}

      assert response == expected_response
    end

    test "returns a task updated when the task is found" do
      user = insert(:user)
      task = insert(:task, %{user_id: user.id})

      response = Update.call(%{"id" => task.id, "title" => "updated_title"})

      assert {:ok, %Task{title: "updated_title"}} = response
    end
  end
end
