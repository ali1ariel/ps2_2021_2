defmodule BlackCat.Repo.Migrations.CreateOfferedServices do
  use Ecto.Migration

  def change do
    create table(:offered_services) do
      add :name, :string
      add :type, :integer

      timestamps()
    end

  end
end
