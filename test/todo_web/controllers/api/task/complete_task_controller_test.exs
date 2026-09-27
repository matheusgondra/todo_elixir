defmodule TodoWeb.Api.Task.CompleteTaskControllerTest do
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

    test "completes a task", %{conn: conn, user_id: user_id} do
      id = insert(:task, %{user_id: user_id}).id

      response =
        conn
        |> patch(~p"/api/tasks/#{id}/complete")
        |> json_response(200)

      assert %{
               "id" => ^id,
               "title" => "any_title",
               "completed" => true,
               "created_at" => _,
               "updated_at" => _
             } = response
    end

    test "returns a 404 status code when the task does not exist", %{conn: conn} do
      response =
        conn
        |> patch(~p"/api/tasks/#{UUID.generate()}/complete")
        |> json_response(404)

      expected_response = %{"message" => "Task not found"}

      assert response == expected_response
    end
  end
end
