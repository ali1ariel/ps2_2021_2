defmodule BlackCatWeb.OfferedServiceController do
  use BlackCatWeb, :controller

  alias BlackCat.OfferedServices
  alias BlackCat.OfferedServices.OfferedService

  plug :put_layout, "admin_app.html"

  def index(conn, _params) do
    offered_services = OfferedServices.list_offered_services()
    render(conn, "index.html", offered_services: offered_services)
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = OfferedServices.change_offered_service(%OfferedService{})
    render(conn, "new.html", changeset: changeset, csrf_token: get_csrf_token())
  end

  def create(conn, %{"offered_service" => offered_service_params}) do

    offered_service_params = Map.put(offered_service_params, "type", String.to_integer(offered_service_params["type"]))

    case OfferedServices.create_offered_service(offered_service_params) do
      {:ok, offered_service} ->
        conn
        |> put_flash(:info, "Offered service created successfully.")
        |> redirect(to: Routes.offered_service_path(conn, :show, offered_service))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, csrf_token: get_csrf_token())
    end
  end

  def show(conn, %{"id" => id}) do
    offered_service = OfferedServices.get_offered_service!(id)
    render(conn, "show.html", offered_service: offered_service)
  end

  def edit(conn, %{"id" => id}) do
    offered_service = OfferedServices.get_offered_service!(id)
    changeset = OfferedServices.change_offered_service(offered_service)
    render(conn, "edit.html", offered_service: offered_service, changeset: changeset, csrf_token: get_csrf_token())
  end

  def update(conn, %{"id" => id, "offered_service" => offered_service_params}) do
    offered_service = OfferedServices.get_offered_service!(id)
    offered_service_params = Map.put(offered_service_params, "type", String.to_integer(offered_service_params["type"]))


    case OfferedServices.update_offered_service(offered_service, offered_service_params) do
      {:ok, offered_service} ->
        conn
        |> put_flash(:info, "Offered service updated successfully.")
        |> redirect(to: Routes.offered_service_path(conn, :show, offered_service))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", offered_service: offered_service, changeset: changeset, csrf_token: get_csrf_token())
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
