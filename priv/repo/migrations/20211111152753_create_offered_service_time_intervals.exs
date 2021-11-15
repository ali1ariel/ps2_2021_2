defmodule BlackCat.Repo.Migrations.CreateOfferedServiceTimeIntervals do
  use Ecto.Migration

  def change do
    create table(:offered_service_time_intervals, primary_key: false) do
      add :init_time, :time
      add :end_time, :time
      add :init_day, :integer
      add :end_day, :integer
      add :offered_service_uuid, references(:offered_services, on_delete: :delete_all)
      add :uuid, :uuid, primary_key: true

      timestamps()
    end

  end
end
