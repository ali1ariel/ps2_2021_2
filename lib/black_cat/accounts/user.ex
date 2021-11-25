defmodule BlackCat.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :profile, Ecto.Enum, values: [admin: 1, unprofiled: 2, profiled: 3, blogger: 4]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :profile])
    |> validate_required([:name, :email, :profile])
  end
end
