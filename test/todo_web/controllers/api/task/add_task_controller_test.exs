defmodule TodoWeb.Api.Task.AddTaskControllerTest do
  use TodoWeb.ConnCase, async: true

  import Todo.Factory

  alias Todo.Tasks.Task
  alias Todo.Repo
  alias TodoWeb.Auth.Guardian

  describe "handle/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "returns a 201 status code", %{conn: conn, user: user} do
      params = build(:task_params, %{"user_id" => user.id})

      conn = post(conn, ~p"/api/tasks", params)

      assert %{
               "id" => id,
               "title" => "any_title",
               "created_at" => _,
               "updated_at" => _
             } = json_response(conn, 201)

      task = Repo.get!(Task, id)

      assert %Task{id: ^id, title: "any_title"} = task
    end

    test "returns a 400 status code when the params are invalid", %{conn: conn, user: user} do
      params = build(:task_params, %{"user_id" => user.id, "title" => nil})

      response =
        conn
        |> post(~p"/api/tasks", params)
        |> json_response(400)

      expected_response = %{"message" => %{"title" => ["can't be blank"]}}

      assert response == expected_response
    end
  end
end
