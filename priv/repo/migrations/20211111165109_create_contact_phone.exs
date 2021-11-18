defmodule BlackCat.Repo.Migrations.CreateContactPhone do
  use Ecto.Migration

  def change do
    create table(:contact_phone, primary_key: false) do
      add :phone, :string
      add :calls?, :boolean, default: false, null: false
      add :whatsapp?, :boolean, default: false, null: false
      add :scheduling?, :boolean, default: true, null: false
      add :id, :uuid, primary_key: true
      add :offered_service_uuid, references(:offered_services, type: :uuid, foreign_key: :id, on_delete: :nothing)

      timestamps()
    end

  end
end
