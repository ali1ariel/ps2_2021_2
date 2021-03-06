defmodule BlackCatWeb.Kaffy.PostAdmin do

  """
    General side menu custom links
  """
  def custom_links(_schema) do
    [
      %{name: "Ver site", url: "/", order: 2, location: :top, icon: "transgender", target: "_blank"},
    ]
  end

  def singular_name(_) do
    "Post"
  end

  def plural_name(_) do
    "Posts"
  end

  def index(_) do
    [
      title: %{name: "Título"},
      body: %{name: "Conteúdo"},
      inserted_at: %{name: "Criado em", value: fn p -> format_datetime!(p.inserted_at) end},
    ]
  end

  def form_fields(_) do
    [
      user_id: %{label: "Autor", create: :readonly, update: :readonly},
      title: %{label: "Título"},
      body: %{label: "Conteúdo", type: :richtext},
      image: %{label: "Imagem", type: :file},
    ]
  end

  # Aux methods
  defp format_datetime!(datetime), do: Timex.format!(datetime, "{D}/{M}/{YYYY} {h24}:{m}")
end
