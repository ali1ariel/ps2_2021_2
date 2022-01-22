defmodule BlackCatWeb.Live.AddressComponent do
  use BlackCatWeb, :live_component
  alias BlackCat.OfferedServices

  def render(assigns) do
    ~H"""
    <div class="flex flex-row">
    <.form let={f} for={@changeset} phx-target={@myself} phx-change="validate_address" id={Ecto.Changeset.get_change(@changeset, :virtual_id) |> Integer.to_string} class="flex flex-col justify-around mx-4 my-2">

    <div class="m-4">
    <%= gettext("Street") %>
    <%= text_input f, :street, phx_update: "ignore" %>
    <%= error_tag f, :street %>
    </div>

    <div class="m-4">
    <%= gettext("Number") %>
    <%= text_input f, :number, phx_update: "ignore" %>
    <%= error_tag f, :number %>
    </div>

    <div class="m-4">
    <%= gettext("References") %>
    <%= text_input f, :references, phx_update: "ignore" %>
    <%= error_tag f, :references %>
    </div>

    <div class="m-4">
    <%= gettext("Complement") %>
    <%= text_input f, :complement, phx_update: "ignore" %>
    <%= error_tag f, :complement %>
    </div>

    <div class="m-4">
    <%= gettext("Postal Code") %>
    <%= text_input f, :postal_code, phx_update: "ignore" %>
    <%= error_tag f, :postal_code %>
    </div>

    <div class="m-4">
    <%= gettext("City") %>
    <%= text_input f, :city, phx_update: "ignore" %>
    <%= error_tag f, :city %>
    </div>

    <div class="m-4">
    <%= gettext("State") %>
    <%= text_input f, :state, phx_update: "ignore" %>
    <%= error_tag f, :state %>
    </div>

    <div class="m-4">
    <%= gettext("Country") %>
    <%= text_input f, :country, phx_update: "ignore" %>
    <%= error_tag f, :country %>
    </div>



      </.form>
        <a href="#" class="flex my-auto rounded hover:bg-event-red-600 hover:text-white bg-red-200 p-4" phx-click="remove_time_interval" phx-value-id={Ecto.Changeset.get_change(@changeset, :virtual_id)}>
          <i class="fas fa-minus text-sm text-black text-xl"></i>
        </a>
    </div>
    """
  end

  def mount(socket), do: {:ok, socket}

  def update(%{id: id, csrf_token: csrf_token, address: address}, socket) do
    assigns = [
      id: id,
      changeset: address,
      csrf_token: csrf_token
    ]

    {:ok, assign(socket, assigns)}
  end

  def handle_event("validate_address", %{"address" => address}, socket) do
    send(
      self(),
      {__MODULE__, :updated_address, %{address: address}}
    )

    {:noreply, socket}
  end
end
