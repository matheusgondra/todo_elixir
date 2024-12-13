defmodule Todo.Tasks.Task do
  use Ecto.Schema

  import Ecto.Changeset

  alias Todo.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields [:title, :user_id]

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
    |> validate_required(@required_fields)
    |> validate_length(:title, min: 5)
  end
end
