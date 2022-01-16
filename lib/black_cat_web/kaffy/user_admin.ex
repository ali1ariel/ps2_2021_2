defmodule BlackCatWeb.Kaffy.UserAdmin do

  def singular_name(_) do
    "Usuário"
  end

  def plural_name(_) do
    "Usuários"
  end

  def index(_) do
    [
      name: %{name: "Nome"},
      email: %{name: "E-mail"},
      profile: %{name: "Perfil",
      filters: [
        {"Sem perfil", "unprofiled"},
        {"Normal", "profiled"},
        {"Admin", "admin"},
        {"Blogger", "blogger"}
      ]
      },
      inserted_at: %{name: "Criado em", value: fn p -> format_datetime!(p.inserted_at) end}
    ]
  end

  def form_fields(_) do
    [
      name: %{label: "Nome", create: :readonly, update: :readonly},
      email: %{label: "E-mail", create: :readonly, update: :readonly},
      profile: %{label: "Perfil", help_text: "Tipo de Perfil do Usuário",
        choices: [
          {"Sem perfil", "unprofiled"},
          {"Normal", "profiled"},
          {"Admin", "admin"},
          {"Blogger", "blogger"}
        ]
      }
    ]
  end

  def ordering(_schema) do
    [desc: :inserted_at]
  end

  defp format_datetime!(datetime), do: Timex.format!(datetime, "{D}/{M}/{YYYY} {h24}:{m}")
end
