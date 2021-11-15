defmodule BlackCat.OfferedServices.Specialty do
  use BlackCat.Schema
  import Ecto.Changeset

  alias BlackCat.OfferedServices.OfferedService

  schema "offered_service_speacialty" do
    field :name, :string

    belongs_to :offered_service, OfferedService

    timestamps()
  end

  @doc false
  def changeset(specialty, attrs) do
    specialty
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
