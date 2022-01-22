defmodule BlackCat.Repo.Migrations.BlogAddImageColumn do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :image, :string
    end
  end
end
