defmodule Pento.Repo.Migrations.AddUsernameField do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :username, :citext, null: false
    end

    create unique_index(:users, [:username])
  end

  def down do
    drop unique_index(:users, [:username])

    alter table(:users) do
      remove :username
    end

  end
end
