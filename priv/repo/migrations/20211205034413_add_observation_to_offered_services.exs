defmodule BlackCat.Repo.Migrations.AddObservationToOfferedServices do
  use Ecto.Migration

  def change do
    alter table(:offered_services) do
      add :observation, :text
    end

  end
end
