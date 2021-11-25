defmodule BlackCat.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :profile, :integer

      timestamps()
    end
  end
end
