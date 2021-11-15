defmodule  BlackCat.OfferedServices do

  alias BlackCat.OfferedServices.OfferedService
  alias BlackCat.Repo

  @doc """
  Returns the list of offered_services.

  ## Examples

      iex> list_offered_services()
      [%OfferedService{}, ...]

  """
  def list_offered_services do
    Repo.all(OfferedService)
  end

  @doc """
  Gets a single offered_service.

  Raises `Ecto.NoResultsError` if the Offered service does not exist.

  ## Examples

      iex> get_offered_service!(123)
      %OfferedService{}

      iex> get_offered_service!(456)
      ** (Ecto.NoResultsError)

  """
  def get_offered_service!(id), do: Repo.get!(OfferedService, id)

  @doc """
  Creates a offered_service.

  ## Examples

      iex> create_offered_service(%{field: value})
      {:ok, %OfferedService{}}

      iex> create_offered_service(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_offered_service(attrs \\ %{}) do
    %OfferedService{}
    |> OfferedService.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a offered_service.

  ## Examples

      iex> update_offered_service(offered_service, %{field: new_value})
      {:ok, %OfferedService{}}

      iex> update_offered_service(offered_service, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_offered_service(%OfferedService{} = offered_service, attrs) do
    offered_service
    |> OfferedService.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a offered_service.

  ## Examples

      iex> delete_offered_service(offered_service)
      {:ok, %OfferedService{}}

      iex> delete_offered_service(offered_service)
      {:error, %Ecto.Changeset{}}

  """
  def delete_offered_service(%OfferedService{} = offered_service) do
    Repo.delete(offered_service)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking offered_service changes.

  ## Examples

      iex> change_offered_service(offered_service)
      %Ecto.Changeset{data: %OfferedService{}}

  """
  def change_offered_service(%OfferedService{} = offered_service, attrs \\ %{}) do
    OfferedService.changeset(offered_service, attrs)
  end
end
