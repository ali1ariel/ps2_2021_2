defmodule BlackCatWeb.OfferedServiceControllerTest do
  use BlackCatWeb.ConnCase

  alias BlackCat.OfferedServices

  @create_attrs %{name: "some name", type: 42}
  @update_attrs %{name: "some updated name", type: 43}
  @invalid_attrs %{name: nil, type: nil}

  def fixture(:offered_service) do
    {:ok, offered_service} = OfferedServices.create_offered_service(@create_attrs)
    offered_service
  end

  describe "index" do
    test "lists all offered_services", %{conn: conn} do
      conn = get(conn, Routes.offered_service_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Offered services"
    end
  end

  describe "new offered_service" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.offered_service_path(conn, :new))
      assert html_response(conn, 200) =~ "New Offered service"
    end
  end

  describe "create offered_service" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.offered_service_path(conn, :create), offered_service: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.offered_service_path(conn, :show, id)

      conn = get(conn, Routes.offered_service_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Offered service"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.offered_service_path(conn, :create), offered_service: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Offered service"
    end
  end

  describe "edit offered_service" do
    setup [:create_offered_service]

    test "renders form for editing chosen offered_service", %{conn: conn, offered_service: offered_service} do
      conn = get(conn, Routes.offered_service_path(conn, :edit, offered_service))
      assert html_response(conn, 200) =~ "Edit Offered service"
    end
  end

  describe "update offered_service" do
    setup [:create_offered_service]

    test "redirects when data is valid", %{conn: conn, offered_service: offered_service} do
      conn = put(conn, Routes.offered_service_path(conn, :update, offered_service), offered_service: @update_attrs)
      assert redirected_to(conn) == Routes.offered_service_path(conn, :show, offered_service)

      conn = get(conn, Routes.offered_service_path(conn, :show, offered_service))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, offered_service: offered_service} do
      conn = put(conn, Routes.offered_service_path(conn, :update, offered_service), offered_service: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Offered service"
    end
  end

  describe "delete offered_service" do
    setup [:create_offered_service]

    test "deletes chosen offered_service", %{conn: conn, offered_service: offered_service} do
      conn = delete(conn, Routes.offered_service_path(conn, :delete, offered_service))
      assert redirected_to(conn) == Routes.offered_service_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.offered_service_path(conn, :show, offered_service))
      end
    end
  end

  defp create_offered_service(_) do
    offered_service = fixture(:offered_service)
    %{offered_service: offered_service}
  end
end
