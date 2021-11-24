defmodule BlackCatWeb.Live.TimeIntervalComponent do
  use BlackCatWeb, :live_component
  alias BlackCat.OfferedServices

  def render(assigns) do
    ~H"""
      <div>
        <div id={"time_interval-#{@id}"}> Secrets from a girl, who seem it all - <%= @id %> </div>
        <button phx-click="ok" phx-value-id="@id+1">action</button>
        <%#= f = form_for OfferedServices.OfferedService.changeset(%OfferedServices.OfferedService{}, %{}), "", [] %>
          <%#= select f, :init_day, Ecto.Enum.mappings(OfferedServices.TimeInterval, :init_day)  %>
          <%#= time_input f, :init_time, precision: :minute %>
          <%#= time_input f, :end_time, precision: :minute %>
        <!--/form-->
      </div>
    """
  end

  def mount(socket), do: {:ok, socket}

  def update(%{id: id}, socket) do
    assigns = [
      id: id
    ]
    {:ok, assign(socket, assigns)}
  end

  def handle_event("ok", %{"id" => id}, socket) do
    send(
      self(),
      {__MODULE__, :updated_time_interval,
       %{time_interval: "time_interval#{id}"}}
    )


    {:noreply, socket}
  end
end
