defmodule Todo.Repo.Migrations.AddTableUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false, size: 50
      add :email, :string, null: false, size: 100
      add :password, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
