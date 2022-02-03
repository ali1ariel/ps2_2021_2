defmodule BlackCatWeb.OfferedServiceFormLive do
  use BlackCatWeb, :live_view
  alias BlackCat.OfferedServices
  alias BlackCatWeb.Live.TimeIntervalComponent
  import BlackCatWeb.Gettext

  def render(assigns) do
    ~L"""
      <div class="flex flex-col w-1/2">
      <%= f = form_for @changeset, @action, [phx_submit: "save"] %>
      <%= if @changeset.action do %>
      <div class="alert alert-danger">
      <p>Oops, something went wrong! Please check the errors below.</p>
      </div>
      <% end %>

    <div class="m-4">
      <%= gettext("Name") %>
      <%= text_input f, :name, phx_update: "ignore", class: "mx-2 px-2 bg-white" %>
      <%= error_tag f, :name %>
    </div>

    <div class="m-4">
      <%= gettext("Service type") %>
      <%= select f, :type, Ecto.Enum.mappings(BlackCat.OfferedServices.OfferedService, :type), phx_update: "ignore", class: "mx-2 px-2 bg-white" %>
      <%= error_tag f, :type %>
    </div>

    <div class="m-4">
        <%= label f, :observation, gettext("Observation") %>
        <%= textarea f, :observation, phx_update: "ignore", class: "mx-2 px-2 bg-white" %>
        <%= error_tag f, :observation %>
    </div>

      <div class="flex flex-row">
      <%= submit "Save", class: "px-2 bg-white text-black ml-auto"%>
      </div>
      </form>

      <div class="flex flex-col">
      <%= for {time_interval, counter} <- Enum.with_index(@time_intervals) do %>
        <div class="flex flex-row">
          <div class="flex my-auto">
            <%= counter+1 %>
          </div>
          <%= live_component TimeIntervalComponent, id: Ecto.Changeset.get_change(time_interval, :virtual_id), csrf_token: @csrf_token, time_interval: time_interval %>
        </div>
      <% end %>
      </div>
      <div class="flex flex-row">
        <a href="#" class="flex flex-row my-auto p-4 bg-green-200 border rounded hover:bg-event-red-600 hover:text-white" phx-click="add_time_interval">
          <i class="fas fa-plus text-sm text-black"></i>
        </a>
      </div>
      </div>
      </div>
      """
  end


  def mount(_params, %{"action" => action, "csrf_token" => csrf_token, "offered_service" => offered_service}, socket) do
      assigns = [
      action: action,
      changeset: OfferedServices.change_offered_service(%OfferedServices.OfferedService{}),
      time_intervals: [],
      ids: 0,
      csrf_token: csrf_token
    ]
    {:ok, assign(socket, assigns)}
  end

  def handle_event("add_time_interval", _, socket) do

    assigns = [
      time_intervals: socket.assigns.time_intervals ++ [OfferedServices.change_time_interval(%OfferedServices.TimeInterval{}, %{virtual_id: socket.assigns.ids + 1})],
      ids: socket.assigns.ids  + 1
    ]
    {:noreply, assign(socket, assigns)}
  end


  def handle_event("validate_time_interval", params, socket) do


    {:noreply, socket}
  end

  def handle_event("save", params, socket) do
    socket.assigns.time_intervals
    |> Enum.map(&(Ecto.Changeset.apply_changes(&1) |> then(fn ti -> (%{init_day: ti.init_day, init_time: ti.init_time, end_time: ti.end_time}) end)))
    |> then(&Map.put(params["offered_service"], "time_intervals", &1))
    |> then(&Map.put(&1, "type", &1["type"] |> String.to_integer))
    |> BlackCat.OfferedServices.create_offered_service()
    |> case do
      {:ok, service} ->
        {:noreply, redirect(socket, to: Routes.offered_service_path(socket, :index))}
      {:error, errors} ->
        {:noreply, assign(socket, [errors: errors])}
    end
  end

  def handle_event("remove_time_interval", %{"id" => id}, socket) do
    time_intervals =  socket.assigns.time_intervals
    to_remove = Enum.find(time_intervals, &(Ecto.Changeset.get_change(&1, :virtual_id) == id |> String.to_integer()))

    assigns = [
      time_intervals: List.delete(time_intervals, to_remove),
      ids: socket.assigns.ids
    ]
    {:noreply, assign(socket, assigns)}
  end

  def handle_info(
        {BlackCatWeb.Live.TimeIntervalComponent, :updated_time_interval,
         %{time_interval: time_interval}},
        socket
      ) do

        time_interval = %{time_interval | "init_day" => time_interval["init_day"] |> String.to_integer()}

        time_intervals =  socket.assigns.time_intervals
        to_update = Enum.find(time_intervals, &(Ecto.Changeset.get_change(&1, :virtual_id) == time_interval["virtual_id"] |> String.to_integer()))

        time_intervals = time_intervals -- [to_update]

        updated = OfferedServices.change_time_interval(%OfferedServices.TimeInterval{}, time_interval)

        time_intervals = (time_intervals ++ [updated]) |> Enum.sort_by(&(Ecto.Changeset.get_change(&1, :virtual_id)))
    {:noreply,
     assign(socket,
        time_intervals: time_intervals,
     )}
  end
end
