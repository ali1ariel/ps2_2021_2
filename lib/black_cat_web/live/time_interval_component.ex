defmodule BlackCatWeb.Live.TimeIntervalComponent do
  use BlackCatWeb, :live_component
  alias BlackCat.OfferedServices

    def render(assigns) do
      ~H"""
      <div class="flex">
      <.form let={f} for={@changeset} phx-target={@myself} phx-change="validate_time_interval" id={Ecto.Changeset.get_change(@changeset, :virtual_id) |> Integer.to_string} class="flex flex-row justify-around mx-4 my-2">
        <%= select f, :init_day, Ecto.Enum.mappings(OfferedServices.TimeInterval, :init_day), class: "mx-2 px-2" %>
        <%= time_input f, :init_time, precision: :minute, value: "00:00", class: "mx-2" %>
        <%= select f, :end_day, Ecto.Enum.mappings(OfferedServices.TimeInterval, :end_day), class: "mx-2 px-2"  %>
        <%= time_input f, :end_time, precision: :minute, value: "23:59", class: "mx-2" %>
        <%= hidden_input f, :virtual_id, value: Ecto.Changeset.get_change(@changeset, :virtual_id), class: "mx-2" %>
      </.form>
        <a href="#" class="flex my-auto rounded hover:bg-event-red-600 hover:text-white bg-red-200 p-4" phx-click="remove_time_interval" phx-value-id={Ecto.Changeset.get_change(@changeset, :virtual_id)}>
          <i class="fas fa-minus text-sm text-black text-xl"></i>
        </a>
    </div>
    """
  end

  def mount(socket), do: {:ok, socket}

  def update(%{id: id, csrf_token: csrf_token, time_interval: time_interval}, socket) do
    assigns = [
      id: id,
      changeset: time_interval,
      csrf_token: csrf_token
    ]
    {:ok, assign(socket, assigns)}
  end

  def handle_event("validate_time_interval", %{"time_interval" => time_interval}, socket) do
    send(
      self(),
      {__MODULE__, :updated_time_interval,
       %{time_interval: time_interval}}
    )


    {:noreply, socket}
  end
end
