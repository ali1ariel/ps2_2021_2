defmodule BlackCatWeb.Live.TimeIntervalComponent do
  use BlackCatWeb, :live_component
  alias BlackCat.OfferedServices

  def render(assigns) do
    ~H"""
      <div>
        <.form let={f} for={@changeset}, phx-target="#{@myself}", phx-change="validate" id={"time_interval-#{@id}"}>
          <%= select f, :init_day, Ecto.Enum.mappings(OfferedServices.TimeInterval, :init_day)  %>
          <%= time_input f, :init_time, precision: :minute, value: "00:00"%>
          <%= time_input f, :end_time, precision: :minute, value: "23:59"%>
        </.form>
      </div>
    """
  end

  def mount(socket), do: {:ok, socket}

  def update(%{id: id, csrf_token: csrf_token, time_interval_changeset: changeset}, socket) do
    assigns = [
      id: id,
      changeset: changeset,
      csrf_token: csrf_token
    ]
    {:ok, assign(socket, assigns)}
  end

  def handle_event("validate", data, socket) do
    IO.inspect data
    send(
      self(),
      {__MODULE__, :updated_time_interval,
       %{time_interval: "time_interval"}}
    )


    {:noreply, socket}
  end
end
