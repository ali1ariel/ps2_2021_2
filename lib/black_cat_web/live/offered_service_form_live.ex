defmodule BlackCatWeb.OfferedServiceFormLive do
  use BlackCatWeb, :live_view
  alias BlackCat.OfferedServices
  alias BlackCatWeb.Live.TimeIntervalComponent

  def render(assigns) do
    ~L"""
      <%= f = form_for OfferedServices.OfferedService.changeset(%OfferedServices.OfferedService{}, %{}), "", [] %>
        <%= if @changeset.action do %>
          <div class="alert alert-danger">
            <p>Oops, something went wrong! Please check the errors below.</p>
          </div>
        <% end %>

        <%= label f, :name %>
        <%= text_input f, :name %>
        <%= error_tag f, :name %>

        <%= label f, :type %>
        <%= select f, :type, Ecto.Enum.mappings(BlackCat.OfferedServices.OfferedService, :type) %>
        <%= error_tag f, :type %>


        <%#= inputs_for f, :time_intervals, fn time_interval -> %>
          <%#= select time_interval, :init_day, Ecto.Enum.mappings(OfferedServices.TimeInterval, :init_day)  %>
          <%#= time_input time_interval, :init_time, precision: :minute %>
          <%#= time_input time_interval, :end_time, precision: :minute %>
        <%# end %>
        <%= for id <- Enum.to_list(0..@ids) do %>
          <%= live_component TimeIntervalComponent, id: id %>
        <% end %>
        <button>Click Me</button>
        <div>
          <%= submit "Save" %>
        </div>
      </form>
    """
  end

  def mount(_params, %{"action" => action, "changeset" => changeset}, socket) do
      IO.inspect assigns = [
      action: action,
      changeset: changeset,
      ids: 0
    ]
    {:ok, assign(socket, assigns)}
  end
  def handle_event("add_time_interval", _, socket) do

  end


  def handle_info(
        {SomaliLiveProjectWeb.EvaluationComponent, :updated_time_interval,
         %{time_interval: time_interval}},
        socket
      ) do
    {:noreply,
     assign(socket,
        time_intervals: [time_interval],
     )}
  end
end