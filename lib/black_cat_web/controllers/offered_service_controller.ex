defmodule BlackCatWeb.OfferedServiceController do
  use BlackCatWeb, :controller

  alias BlackCat.OfferedServices
  alias BlackCat.OfferedServices.OfferedService

  def index(conn, _params) do
    offered_services = OfferedServices.list_offered_services()
    render(conn, "index.html", offered_services: offered_services)
  end

  def new(conn, _params) do
    changeset = OfferedServices.change_offered_service(%OfferedService{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"offered_service" => offered_service_params}) do
    case OfferedServices.create_offered_service(offered_service_params) do
      {:ok, offered_service} ->
        conn
        |> put_flash(:info, "Offered service created successfully.")
        |> redirect(to: Routes.offered_service_path(conn, :show, offered_service))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    offered_service = OfferedServices.get_offered_service!(id)
    render(conn, "show.html", offered_service: offered_service)
  end

  def edit(conn, %{"id" => id}) do
    offered_service = OfferedServices.get_offered_service!(id)
    changeset = OfferedServices.change_offered_service(offered_service)
    render(conn, "edit.html", offered_service: offered_service, changeset: changeset)
  end

  def update(conn, %{"id" => id, "offered_service" => offered_service_params}) do
    offered_service = OfferedServices.get_offered_service!(id)

    case OfferedServices.update_offered_service(offered_service, offered_service_params) do
      {:ok, offered_service} ->
        conn
        |> put_flash(:info, "Offered service updated successfully.")
        |> redirect(to: Routes.offered_service_path(conn, :show, offered_service))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", offered_service: offered_service, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    offered_service = OfferedServices.get_offered_service!(id)
    {:ok, _offered_service} = OfferedServices.delete_offered_service(offered_service)

    conn
    |> put_flash(:info, "Offered service deleted successfully.")
    |> redirect(to: Routes.offered_service_path(conn, :index))
  end
end
