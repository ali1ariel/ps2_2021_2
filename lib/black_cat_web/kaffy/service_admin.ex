defmodule BlackCatWeb.Kaffy.ServiceAdmin do

  def singular_name(_) do
    "Serviço"
  end

  def plural_name(_) do
    "Serviços"
  end

  def index(_) do
    [
      name: %{name: "Nome"},
      type: %{name: "Tipo",
      filters: [
        {"Público", "public"},
        {"Privado", "private"}
      ]},
      observation: %{name: "Observações"},
      inserted_at: %{name: "Criado em", value: fn p -> format_datetime!(p.inserted_at) end}
    ]
  end

  def form_fields(_) do
    [
      name: %{label: "Nome"},
      type: %{label: "Tipo",
      choices: [
        {"Público", "public"},
        {"Privado", "private"}
      ]},
      observation: %{label: "Observações", type: :richtext}
    ]
  end

  def ordering(_schema) do
    [desc: :inserted_at]
  end

  defp format_datetime!(datetime), do: Timex.format!(datetime, "{D}/{M}/{YYYY} {h24}:{m}")
end
