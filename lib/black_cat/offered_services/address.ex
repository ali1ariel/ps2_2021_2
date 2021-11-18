defmodule BlackCat.OfferedServices.Address do
  use BlackCat.Schema
  import Ecto.Changeset

  schema "offered_service_address" do
    field :city, :string
    field :complement, :string
    field :country, :string
    field :geocode, :string
    field :number, :string
    field :postal_code, :string
    field :references, :string
    field :state, :string
    field :street, :string

    belongs_to :offered_service, BlackCat.OfferedServices.OfferedService

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:postal_code, :city, :state, :country, :street, :number, :complement, :references, :geocode])
    |> validate_required([:postal_code, :city, :state, :country, :street, :number, :complement, :references, :geocode])
  end
end
