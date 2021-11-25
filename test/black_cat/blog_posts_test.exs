defmodule BlackCat.BlogPostsTest do
  use BlackCat.DataCase

  alias BlackCat.BlogPosts

  describe "posts" do
    alias BlackCat.BlogPosts.Post

    import BlackCat.BlogPostsFixtures

    @invalid_attrs %{body: nil, title: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert BlogPosts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert BlogPosts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{body: "some body", title: "some title"}

      assert {:ok, %Post{} = post} = BlogPosts.create_post(valid_attrs)
      assert post.body == "some body"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BlogPosts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{body: "some updated body", title: "some updated title"}

      assert {:ok, %Post{} = post} = BlogPosts.update_post(post, update_attrs)
      assert post.body == "some updated body"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = BlogPosts.update_post(post, @invalid_attrs)
      assert post == BlogPosts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = BlogPosts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> BlogPosts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = BlogPosts.change_post(post)
    end
  end
end
