defmodule BlackCat.BlogPosts.Post do
  use Ecto.Schema

  import Ecto.Changeset

  alias BlackCat.BlogPosts.Comment
  alias BlackCat.Accounts.User
  alias BlackCatWeb.Helpers.CustomImageField

  @upload_directory Application.get_env(:black_cat, :upload_directory)

  schema "posts" do
    field :body, :string
    field :title, :string
    field :image, CustomImageField

    belongs_to :user, User
    has_many :comments, Comment

    timestamps()
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :user_id, :image])
    |> validate_required([:title, :body, :user_id])
    |> foreign_key_constraint(:user_id)
  end

  def local_path(filename) do
    [@upload_directory, "#{filename}"]
    |> Path.join()
  end

  def sha256(chunks_enum) do
    chunks_enum
    |> Enum.reduce(
        :crypto.hash_init(:sha256),
        &(:crypto.hash_update(&2, &1))
    )
    |> :crypto.hash_final()
    |> Base.encode16()
    |> String.downcase()
  end

end
