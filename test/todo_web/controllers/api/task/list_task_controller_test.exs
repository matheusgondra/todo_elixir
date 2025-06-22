defmodule TodoWeb.Api.Task.ListTaskControllerTest do
  use TodoWeb.ConnCase, async: true

  import Todo.Factory

  alias TodoWeb.Auth.Guardian

  describe "handle/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "returns a list of tasks", %{conn: conn, user: %{id: id}} do
      insert_list(3, :task, %{user_id: id})
      params = %{"page" => "1", "limit" => "1"}

      response =
        conn
        |> get("/api/tasks", params)
        |> json_response(200)

      assert %{
               "data" => [
                 %{
                   "id" => _,
                   "title" => "any_title",
                   "completed" => false,
                   "created_at" => _,
                   "updated_at" => _
                 }
               ],
               "page" => 1,
               "limit" => 1
             } = response
    end

    test "returns ten tasks when param limit is not passed", %{conn: conn, user: %{id: id}} do
      insert_list(10, :task, %{user_id: id})
      params = %{"page" => "1"}

      response =
        conn
        |> get("/api/tasks", params)
        |> json_response(200)

      assert length(response["data"]) == 10
      assert response["limit"] == 10
      assert response["page"] == 1
    end

    test "returns page two of tasks", %{conn: conn, user: %{id: id}} do
      insert_list(20, :task, %{user_id: id})
      params = %{"page" => "2", "limit" => "10"}

      response =
        conn
        |> get("/api/tasks", params)
        |> json_response(200)

      assert length(response["data"]) == 10
      assert response["limit"] == 10
      assert response["page"] == 2
    end

    test "returns empty list when there are no tasks", %{conn: conn} do
      params = %{"page" => "1", "limit" => "10"}

      response =
        conn
        |> get("/api/tasks", params)
        |> json_response(200)

      assert response == %{"data" => [], "page" => 1, "limit" => 10}
    end

    test "returns page one and ten tasks when limit or page is not passed", %{
      conn: conn,
      user: %{id: id}
    } do
      insert_list(20, :task, %{user_id: id})
      params = %{}

      response =
        conn
        |> get("/api/tasks", params)
        |> json_response(200)

      assert length(response["data"]) == 10
      assert response["limit"] == 10
      assert response["page"] == 1
    end
  end
end
