defmodule TodoWeb.Api.Task.UpdateTitleTaskControllerTest do
  use TodoWeb.ConnCase, async: true

  import Todo.Factory

  alias Ecto.UUID
  alias TodoWeb.Auth.Guardian

  describe "handle/2" do
    setup %{conn: conn} do
      user = insert(:user)

      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user_id: user.id}
    end

    test "returns the updated task", %{conn: conn, user_id: user_id} do
      task = insert(:task, %{user_id: user_id})
      params = %{"title" => "New Title"}

      response =
        conn
        |> patch(~p"/api/tasks/#{task.id}", params)
        |> json_response(200)

      assert %{"title" => "New Title"} = response
    end

    test "returns an error when the task is not found", %{conn: conn} do
      params = %{"title" => "New Title"}

      response =
        conn
        |> patch(~p"/api/tasks/#{UUID.generate()}", params)
        |> json_response(404)

      expected_response = %{"message" => "Task not found"}

      assert response == expected_response
    end
  end
end
