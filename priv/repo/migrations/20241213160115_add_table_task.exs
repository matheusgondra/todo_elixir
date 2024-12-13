defmodule Todo.Repo.Migrations.AddTableTask do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :completed, :boolean, default: false
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
  end
end
