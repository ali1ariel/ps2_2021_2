defmodule BlackCatWeb.PostController do
  use BlackCatWeb, :controller

  alias BlackCat.BlogPosts
  alias BlackCat.BlogPosts.Post
  alias BlackCat.BlogPosts.Comment
  alias BlackCat.Repo


  plug :scrub_params, "comment" when action in [:add_comment]
  plug :put_layout, "root.html"

  # method to handle comments on each blog post
  def add_comment(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    changeset = Comment.changeset(%Comment{}, Map.put(comment_params, "post_id", post_id))
    post = Post |> Repo.get(post_id) |> Repo.preload([:comments])

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Comment added.")
      |> redirect(to: Routes.post_path(conn, :show, post))
    else
      render(conn, "show.html", post: post, changeset: changeset)
    end
  end

  def index(conn, _params) do
    posts = BlogPosts.list_posts()
    render(conn, "index.html", posts: posts)
    # posts = BlogPosts
    # |> BlogPosts.count_comments
    # |> Repo.all
    # render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = BlogPosts.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case BlogPosts.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post criado com sucesso!")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    # post = BlogPosts.get_post!(id)
    # render(conn, "show.html", post: post)
    post = BlogPosts.get_post!(id) |> Repo.preload([:comments])
    changeset = Comment.changeset(%Comment{})
    render(conn, "show.html", post: post, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = BlogPosts.get_post!(id)
    changeset = BlogPosts.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = BlogPosts.get_post!(id)

    case BlogPosts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post atualizado com sucesso!")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = BlogPosts.get_post!(id)
    {:ok, _post} = BlogPosts.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
