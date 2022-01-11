defmodule BlackCatWeb.CommentController do
  use BlackCatWeb, :controller

  alias BlackCat.BlogPosts.Comment
  alias BlackCat.BlogPosts.Post
  alias BlackCat.Repo

  plug :scrub_params, "comment" when action in [:create, :update]


  def create(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    post = Repo.get!(Post, post_id) |> Repo.preload([:comments])
    changeset = post
      |> Ecto.build_assoc(:comments)
      |> Comment.changeset(comment_params)
    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully!")
        |> redirect(to: Routes.post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, BlackCat.PostView, "show.html", post: post, comments: changeset)
    end
  end

  def update(conn, _), do: conn
  def delete(conn, _), do: conn
end
