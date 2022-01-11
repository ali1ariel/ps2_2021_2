defmodule BlackCat.BlogPosts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias BlackCat.BlogPosts.Comment
  alias BlackCat.Accounts.User

  schema "posts" do
    field :body, :string
    field :title, :string

    has_one :user, User
    has_many :comments, Comment

    timestamps()
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
