defmodule BlackCat.BlogPosts do
  @moduledoc """
  The BlogPosts context.
  """

  import Ecto.Query, warn: false
  alias BlackCat.Repo

  alias BlackCat.BlogPosts.Post
  alias BlackCat.BlogPosts

  @upload_directory Application.get_env(:black_cat, :upload_directory)

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # def create_post(attrs \\ %{}) do
  #   %Post{}
  #   |> Post.changeset(attrs)
  #   |> Repo.insert()
  # end

  def create_post(%Plug.Upload{filename: filename, path: tmp_path, content_type: content_type}) do
    {:ok, filename} = get_unique_filename(filename)
    {:ok, _} = pre_upload_file(tmp_path, filename, content_type)

    with {:ok, upload} <-
      %Post{}
      |> Post.changeset(%{
        image: filename})
      |> Repo.insert()
    do
      {:ok, upload}
    else
      {:error, reason}=error -> error
    end
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end


  # def count_comments (query) do
  #   from p in query,
  #     group_by: p.id,
  #     left_join: c in assoc(p, :comments),
  #     select: {p, count(c.id)}
  # end

  def get_upload!(id) do
    Post
    |> Repo.get!(id)
  end

  def list_uploads do
    Post |> order_by(desc: :id) |> Repo.all
  end

  def list_uploads_full do
    res = list_uploads
    |> add_full_filepath
  end

  defp add_full_filepath(uploads) do
    Enum.map(uploads, fn up ->
      Map.put up, :full_filepath, "#{@upload_directory}/#{up.filename}"
    end)
  end

  defp get_unique_filename(filename) do
    {:ok, Ecto.UUID.generate() <> "-" <> filename}
  end

  defp get_file_info(tmp_path) do
    hash = File.stream!(tmp_path, [], 2048) |> Post.sha256()
    with {:ok, %File.Stat{size: size}} <- File.stat(tmp_path)
    do
      {:ok, [hash, size]}
    else
      {:error, reason}=error -> error
    end
  end

  defp pre_upload_file(tmp_path, filename, content_type) do
    File.cp(tmp_path, Post.local_path(filename))
    {:ok, ''}
  end

  def create_upload(%Plug.Upload{filename: filename, path: tmp_path, content_type: content_type}) do
    {:ok, filename} = get_unique_filename(filename)
    {:ok, _} = pre_upload_file(tmp_path, filename, content_type)

    with {:ok, upload} <-
      %Post{} |> Post.changeset(%{
        image: filename})
      |> Repo.insert()
    do
      {:ok, upload}
    else
      {:error, reason}=error -> error
    end
  end

  def update_upload(upload_id, %Plug.Upload{filename: filename, path: tmp_path, content_type: content_type}) do
    {:ok, filename} = get_unique_filename(filename)
    {:ok, _} = pre_upload_file(tmp_path, filename, content_type)

    with upload <- BlogPosts.get_upload!(upload_id),
      {:ok, upload} <-
        upload |> Post.changeset(%{
        image: filename})
      |> Repo.update()
    do
      {:ok, upload}
    else
      {:error, reason}=error -> error
    end
  end
end
