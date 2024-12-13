defmodule Todo.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Todo.Tasks.Task

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields [:name, :email, :password]

  @type t() :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          email: String.t(),
          password: String.t(),
          hashed_password: String.t(),
          tasks: list(Task.t()),
          created_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string, source: :password

    has_many :tasks, Task

    timestamps(inserted_at: :created_at)
  end

  @spec changeset(map()) :: Ecto.Changeset.t()
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> put_pass_hash()
    |> unique_constraint(:email, message: "email already exists")
  end

  defp put_pass_hash(changeset) do
    case get_change(changeset, :password) do
      nil ->
        changeset

      password ->
        changeset
        |> put_change(:hashed_password, Pbkdf2.hash_pwd_salt(password))
        |> delete_change(:password)
    end
  end
end
