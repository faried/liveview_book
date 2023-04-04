defmodule Pento.Repo.Migrations.AddImageToProducts do
  use Ecto.Migration

  def up do
    alter table(:products) do
      add :image_upload, :string
    end
  end

  def down do
    alter table(:products) do
      remove :image_upload
    end
  end
end
