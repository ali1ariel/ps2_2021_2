defmodule BlackCat.Repo.Migrations.CreateContactEmails do
  use Ecto.Migration

  def change do
    create table(:contact_emails) do
      add :email, :string
      add :scheduling?, :boolean, default: false, null: false

      timestamps()
    end

  end
end
