defmodule BlackCat.Contact.Email do
  use BlackCat.Schema
  import Ecto.Changeset

  schema "contact_emails" do
    field :email, :string
    field :scheduling?, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(email, attrs) do
    email
    |> cast(attrs, [:email, :scheduling?])
    |> validate_required([:email, :scheduling?])
  end
end
