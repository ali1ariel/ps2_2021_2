defmodule BlackCat.Repo.Migrations.CreateOfferedServices do
  use Ecto.Migration

  def change do
    create table(:offered_services, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :type, :integer

      timestamps()
    end

  end
end
