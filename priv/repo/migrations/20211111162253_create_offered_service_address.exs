defmodule BlackCat.Repo.Migrations.CreateOfferedServiceAddress do
  use Ecto.Migration

  def change do
    create table(:offered_service_address, primary_key: false) do
      add :postal_code, :string
      add :city, :string
      add :state, :string
      add :country, :string
      add :street, :string
      add :number, :string
      add :complement, :string
      add :references, :string
      add :geocode, :string
      add :uuid, :uuid, primary_key: true
      add :offered_service_uuid, references(:offered_services, on_delete: :delete_all)


      timestamps()
    end

  end
end
