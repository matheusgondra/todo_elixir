defmodule Todo.Tasks.GetByPageTest do
  use Todo.DataCase, async: true

  import Todo.Factory

  alias Todo.Tasks.GetByPage

  describe "call/2" do
    setup do
      user = insert(:user, %{}, returning: true)

      {:ok, user: user}
    end

    test "returns a list of tasks", %{user: user} do
      insert_list(3, :task, %{user_id: user.id})

      response = GetByPage.call()

      assert length(response) == 3
    end

    test "returns a list of task according to the page and page_size", %{user: user} do
      insert_list(10, :task, %{user_id: user.id})

      response = GetByPage.call(2, 5)

      assert length(response) == 5
    end

    test "returns a empty list when there is no task" do
      response = GetByPage.call()

      assert length(response) == 0
    end
  end
end
