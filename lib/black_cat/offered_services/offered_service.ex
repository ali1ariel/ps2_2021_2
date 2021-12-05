defmodule BlackCat.OfferedServices.OfferedService do
  use BlackCat.Schema
  import Ecto.Changeset

  alias BlackCat.OfferedServices.HealthPlan
  alias BlackCat.OfferedServices.Specialty
  alias BlackCat.OfferedServices.Address
  alias BlackCat.OfferedServices.TimeInterval
  alias BlackCat.Contact.Email
  alias BlackCat.Contact.Phone

  schema "offered_services" do
    field :name, :string
    field :observation, :string
    field :type, Ecto.Enum, values: [private: 1, public: 2]

    has_many :time_intervals, TimeInterval
    has_many :specialties, Specialty
    has_many :health_plans, HealthPlan
    has_one :address, Address

    has_many :emails, Email
    has_many :phones, Phone

    timestamps()
  end

  @doc false
  def changeset(offered_service, attrs) do
    offered_service
    |> cast(attrs, [:name, :type, :observation])
    |> validate_required([:name, :type, :observation])
  end
end
