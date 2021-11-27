defmodule BlackCat.BlogPosts.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :content, :string
    field :name, :string
    belongs_to :posts, BlackCat.BlogPosts.Post, foreign_key: :post_id

    timestamps()
  end

  # @required_fields ~w(name content post_id)
  # @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.
  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  # def changeset(model, params \\ :empty) do
  #   model
  #   |> cast(params, @required_fields, @optional_fields)
  # end

  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:name, :content])
    |> validate_required([:name, :content])
  end

  # def changeset_comments(%Comment{} = comment, attrs \\ %{}) do
  #   Comment.changeset(comment, attrs)
  # end
end
