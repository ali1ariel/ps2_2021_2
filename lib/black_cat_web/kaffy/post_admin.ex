defmodule BlackCatWeb.Kaffy.PostAdmin do

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
      action: %{name: "Ações", value: "editar excluir"},
    ]
  end

  def form_fields(_) do
    [
      title: %{label: "Título"},
      body: %{label: "Conteúdo", type: :richtext},
    ]
  end

  # Aux methods
  defp format_datetime!(datetime), do: Timex.format!(datetime, "{D}/{M}/{YYYY} {h24}:{m}")
end
