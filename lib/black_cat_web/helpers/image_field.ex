defmodule BlackCatWeb.Helpers.CustomImageField do
  use Ecto.Type

  def type, do: :string

  alias BlackCat.BlogPosts.Post
  alias BlackCatWeb.Router.Helpers, as: Routes

  def cast(data) do
    # IO.inspect("cast - data: #{inspect(data)}")
    {:ok, data}
  end

  # if the input is not a string, return an error
  def cast(_), do: :error

  def load(data) do
    # IO.inspect("load - data: #{inspect(data)}")
    {:ok, data}
  end

  # When dumping data to the database, we *expect* an URI struct
  # but any value could be inserted into the schema struct at runtime,
  # so we need to guard against them.
  # def dump(%URI{} = uri), do: {:ok, Map.from_struct(uri)}
  def dump(data), do: {:ok, data}
  def dump(_), do: :error

  # this function should return the HTML related to rendering the customized form field.
  def render_form(conn, changeset, form, field, _options) do
    img_div = if form.data.image do
      [
        {:safe, ~s(<p><b>Current image:</b> #{form.data.image}</p>)},
        {:safe, ~s(<div class="form-group">)},
        Phoenix.HTML.Tag.img_tag(Routes.static_url(conn, "/" <> Post.local_path(form.data.image))),
        {:safe, ~s(</div>)}
      ]
    else
      {:safe, ''}
    end
    [
      img_div,
      {:safe, ~s(<div class="form-group">)},
      Phoenix.HTML.Form.label(form, field, "Imagem"),
      Phoenix.HTML.Form.file_input(form, field,
        class: "form-control",
        name: "#{form.name}[#{field}]"
      ),
      {:safe, ~s(</div>)}
    ]
  end

  # this is how the field should be rendered on the index page
  def render_index(conn, resource, field, _options) do
    case Map.get(resource, field) do
      nil ->
        ""
      details ->
        image = details
        [
          Phoenix.HTML.Tag.img_tag(Routes.static_url(conn, "/" <> Post.local_path(image)))
        ]
    end
  end

  defp get_field_value(changeset, field) do
    field_value = Map.get(changeset.data, field)
    field_value
  end
end
