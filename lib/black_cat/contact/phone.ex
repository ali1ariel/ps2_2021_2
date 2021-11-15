defmodule BlackCat.Contact.Phone do
  use BlackCat.Schema
  import Ecto.Changeset

  schema "contact_phone" do
    field :calls?, :boolean, default: false
    field :phone, :string
    field :scheduling?, :boolean, default: false
    field :whatsapp?, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(phone, attrs) do
    phone
    |> cast(attrs, [:phone, :calls?, :whatsapp?, :scheduling?])
    |> validate_required([:phone, :calls?, :whatsapp?, :scheduling?])
  end
end
