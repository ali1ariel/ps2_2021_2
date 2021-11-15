defmodule BlackCat.OfferedServices.TimeInterval do
  use BlackCat.Schema
  import Ecto.Changeset

  schema "offered_service_time_intervals" do
    field :init_time, :time
    field :end_time, :time
    field :init_day, Ecto.Enum, values: [monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7]
    field :end_day, Ecto.Enum, values: [monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7]

    timestamps()
  end

  @doc false
  def changeset(time_interval, attrs) do
    time_interval
    |> cast(attrs, [:init_time, :end_time, :init_day, :end_day])
    |> validate_required([:init_time, :end_time, :init_day, :end_day])
  end
end
