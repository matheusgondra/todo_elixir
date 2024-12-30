defmodule Todo.Tasks.Task do
  use Ecto.Schema

  import Ecto.Changeset

  alias Todo.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields [:title, :user_id]
  @updated_fields [:title, :completed]

  @type t() :: %__MODULE__{
          id: String.t(),
          title: String.t(),
          completed: boolean(),
          user_id: String.t(),
          user: User.t(),
          created_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "tasks" do
    field :title, :string
    field :completed, :boolean, default: false

    belongs_to :user, User

    timestamps(inserted_at: :created_at)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> do_validations(@required_fields)
  end

  def changeset(task, params) do
    task
    |> cast(params, @updated_fields)
    |> do_validations(@updated_fields)
  end

  defp do_validations(changeset, fields) do
    changeset
    |> validate_required(fields)
    |> validate_length(:title, min: 5)
  end
end
