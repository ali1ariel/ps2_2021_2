defmodule BlackCatWeb.Live.TimeIntervalComponent do
  use BlackCatWeb, :live_component
  alias BlackCat.OfferedServices

  def render(assigns) do
    ~L"""
      <%= f = form_for OfferedServices.OfferedService.changeset(%OfferedServices.OfferedService{}, %{}), "", [] %>
        <%= select f, :init_day, Ecto.Enum.mappings(OfferedServices.TimeInterval, :init_day)  %>

        <%= time_input f, :init_time, precision: :minute %>
        <%= time_input f, :end_time, precision: :minute %>
      </form>
    """
  end

  def mount(socket), do: {:ok, socket}

  def update(%{}, socket) do
    assigns = []
    {:ok, assign(socket, assigns)}
  end
end
