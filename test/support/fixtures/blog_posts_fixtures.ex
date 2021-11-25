defmodule BlackCat.BlogPostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlackCat.BlogPosts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> BlackCat.BlogPosts.create_post()

    post
  end
end
