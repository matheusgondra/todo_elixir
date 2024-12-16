defmodule Todo.Tasks.TaskTest do
  use Todo.DataCase, async: true

  import Todo.Factory

  alias Ecto.Changeset
  alias Todo.Tasks.Task

  describe "changeset/1" do
    test "returns a valid changeset" do
      user = insert(:user, %{}, returning: true)
      id = user.id

      params = build(:task_params, %{"user_id" => id})

      changeset = Task.changeset(params)

      assert %Changeset{
               valid?: true,
               changes: %{title: "any_title", user_id: ^id}
             } = changeset
    end

    test "returns an invalid changeset" do
      insert(:user)

      params = build(:task_params, %{"title" => "err"})

      changeset = Task.changeset(params)

      assert %Changeset{
               valid?: false,
               errors: [
                 title:
                   {"should be at least %{count} character(s)",
                    [count: 5, validation: :length, kind: :min, type: :string]}
               ]
             } = changeset
    end
  end
end
