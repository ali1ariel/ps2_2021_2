defmodule BlackCat.Repo.Migrations.CreateOfferedServiceSpecialties do
  use Ecto.Migration

  def change do
    create table(:offered_service_specialties, primary_key: false) do
      add :name, :string
      add :uuid, :uuid, primary_key: true
      add :offered_service_uuid, references(:offered_services, on_delete: :nothing)

      timestamps()
    end

  end
end
