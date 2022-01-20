defmodule BlackCat.Repo.Migrations.AlterFieldsInOfferedServiceTimeIntervals do
  use Ecto.Migration

  def change do
    alter table(:offered_service_time_intervals) do
      remove :offered_service_uuid
      add :offered_service_id, references(:offered_services, type: :uuid, foreign_key: :id, on_delete: :delete_all)
    end
  end
end
