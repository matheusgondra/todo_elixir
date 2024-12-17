defmodule Todo.Tasks.GetByPage do
  import Ecto.Query

  alias Todo.Repo
  alias Todo.Tasks.Task

  @spec call(pos_integer(), pos_integer()) :: list(Task.t())
  def call(page \\ 1, page_size \\ 10) do
    IO.inspect(%{page: page, page_size: page_size}, label: "Params")
    offset = (page - 1) * page_size

    query = from(t in Task)

    query
    |> limit(^page_size)
    |> offset(^offset)
    |> Repo.all()
  end
end
