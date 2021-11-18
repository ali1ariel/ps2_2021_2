defmodule BlackCat.Repo.Migrations.CreateOfferedServiceTimeIntervals do
  use Ecto.Migration

  def change do
    create table(:offered_service_time_intervals, primary_key: false) do
      add :init_time, :time
      add :end_time, :time
      add :init_day, :integer
      add :end_day, :integer
      add :offered_service_uuid, references(:offered_services, type: :uuid, foreign_key: :id, on_delete: :delete_all)
      add :id, :uuid, primary_key: true

      timestamps()
    end

  end
end
