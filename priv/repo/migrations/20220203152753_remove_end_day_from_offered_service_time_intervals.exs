defmodule BlackCat.Repo.Migrations.RemoveEndDayFromOfferedServiceTimeIntervals do
  use Ecto.Migration

  def change do
    alter table(:offered_service_time_intervals) do
      remove :end_day, :integer
     end

  end
end
