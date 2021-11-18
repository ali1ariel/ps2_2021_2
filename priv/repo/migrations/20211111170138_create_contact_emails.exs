defmodule BlackCat.Repo.Migrations.CreateContactEmails do
  use Ecto.Migration

  def change do
    create table(:contact_emails) do
      add :email, :string
      add :scheduling?, :boolean, default: false, null: false
      add :offered_service_uuid, references(:offered_services, type: :uuid, foreign_key: :id, on_delete: :nothing)

      timestamps()
    end

  end
end
