defmodule TodoWeb.Task.ListTaskController do
  use TodoWeb, :controller

  alias TodoWeb.FallbackController
  alias TodoWeb.Task.TaskJSON

  action_fallback FallbackController

  def handle(conn, %{"page" => page, "limit" => page_size}) do
    do_handle(conn, String.to_integer(page), String.to_integer(page_size))
  end

  def handle(conn, %{"page" => page}) do
    do_handle(conn, String.to_integer(page), 10)
  end

  def handle(conn, %{"limit" => page_size}) do
    do_handle(conn, 1, String.to_integer(page_size))
  end

  def handle(conn, _params) do
    do_handle(conn, 1, 10)
  end

  defp do_handle(conn, page, page_size) do
    with tasks <- Todo.list_tasks(page, page_size) do
      conn
      |> put_status(:ok)
      |> put_view(TaskJSON)
      |> render(:page, tasks: tasks, page: page, limit: page_size)
    end
  end
end
