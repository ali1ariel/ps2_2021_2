defmodule BlackCat.OfferedServices.HealthPlan do
  use BlackCat.Schema
  import Ecto.Changeset

  schema "offered_service_health_plans" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(health_plan, attrs) do
    health_plan
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
