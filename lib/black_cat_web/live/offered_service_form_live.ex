defmodule BlackCatWeb.OfferedServiceFormLive do
  use BlackCatWeb, :live_view
  alias BlackCat.OfferedServices
  alias BlackCatWeb.Live.TimeIntervalComponent
  import BlackCatWeb.Gettext

  def render(assigns) do
    ~L"""
      <%= f = form_for @changeset, @action, [] %>
        <%= if @changeset.action do %>
          <div class="alert alert-danger">
            <p>Oops, something went wrong! Please check the errors below.</p>
          </div>
        <% end %>

        <%= label f, :name, gettext("Name") %>
        <%= text_input f, :name %>
        <%= error_tag f, :name %>

        <%= gettext("Service type") %>
        <%= select f, :type, Ecto.Enum.mappings(BlackCat.OfferedServices.OfferedService, :type) %>
        <%= error_tag f, :type %>


        <%#= inputs_for f, :time_intervals, fn time_interval -> %>
          <%#= select time_interval, :init_day, Ecto.Enum.mappings(OfferedServices.TimeInterval, :init_day)  %>
          <%#= time_input time_interval, :init_time, precision: :minute %>
          <%#= time_input time_interval, :end_time, precision: :minute %>
        <%# end %>

        <%#= label f, :time_intervals %>
        <%#= for id <- Enum.to_list(0..@ids) do %>
          <%#= live_component TimeIntervalComponent, id: "id1", time_interval_changeset: @time_interval_changeset, csrf_token: @csrf_token %>
        <%# end %>
        <div>
          <%= submit gettext("Save") %>
        </div>
      </form>
    """
  end

  def mount(_params, %{"action" => action, "csrf_token" => csrf_token}, socket) do
      assigns = [
      action: action,
      changeset: OfferedServices.change_offered_service(%OfferedServices.OfferedService{}),
      # time_interval_changeset: OfferedServices.change_time_interval(%OfferedServices.TimeInterval{}),
      ids: 0,
      # time_intervals: [],
      csrf_token: csrf_token
    ]
    {:ok, assign(socket, assigns)}
  end
  def handle_event("add_time_interval", _, _socket) do

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
