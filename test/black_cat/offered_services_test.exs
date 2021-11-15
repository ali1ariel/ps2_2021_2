defmodule BlackCat.OfferedServicesTest do
  use BlackCat.DataCase

  alias BlackCat.OfferedServices

  describe "offered_services" do
    alias BlackCat.OfferedServices.OfferedService

    @valid_attrs %{name: "some name", type: 42}
    @update_attrs %{name: "some updated name", type: 43}
    @invalid_attrs %{name: nil, type: nil}

    def offered_service_fixture(attrs \\ %{}) do
      {:ok, offered_service} =
        attrs
        |> Enum.into(@valid_attrs)
        |> OfferedServices.create_offered_service()

      offered_service
    end

    test "list_offered_services/0 returns all offered_services" do
      offered_service = offered_service_fixture()
      assert OfferedServices.list_offered_services() == [offered_service]
    end

    test "get_offered_service!/1 returns the offered_service with given id" do
      offered_service = offered_service_fixture()
      assert OfferedServices.get_offered_service!(offered_service.id) == offered_service
    end

    test "create_offered_service/1 with valid data creates a offered_service" do
      assert {:ok, %OfferedService{} = offered_service} = OfferedServices.create_offered_service(@valid_attrs)
      assert offered_service.name == "some name"
      assert offered_service.type == 42
    end

    test "create_offered_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OfferedServices.create_offered_service(@invalid_attrs)
    end

    test "update_offered_service/2 with valid data updates the offered_service" do
      offered_service = offered_service_fixture()
      assert {:ok, %OfferedService{} = offered_service} = OfferedServices.update_offered_service(offered_service, @update_attrs)
      assert offered_service.name == "some updated name"
      assert offered_service.type == 43
    end

    test "update_offered_service/2 with invalid data returns error changeset" do
      offered_service = offered_service_fixture()
      assert {:error, %Ecto.Changeset{}} = OfferedServices.update_offered_service(offered_service, @invalid_attrs)
      assert offered_service == OfferedServices.get_offered_service!(offered_service.id)
    end

    test "delete_offered_service/1 deletes the offered_service" do
      offered_service = offered_service_fixture()
      assert {:ok, %OfferedService{}} = OfferedServices.delete_offered_service(offered_service)
      assert_raise Ecto.NoResultsError, fn -> OfferedServices.get_offered_service!(offered_service.id) end
    end

    test "change_offered_service/1 returns a offered_service changeset" do
      offered_service = offered_service_fixture()
      assert %Ecto.Changeset{} = OfferedServices.change_offered_service(offered_service)
    end
  end
end
