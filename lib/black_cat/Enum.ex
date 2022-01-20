defmodule BlackCat.Enum do

  import Ecto.Enum
  import BlackCatWeb.Gettext

  def mappings(schema, field) do
    Ecto.Enum.mappings(schema, field)
    |> Enum.map(fn {key, value} ->  { Gettext.gettext(BlackCatWeb.Gettext, Atom.to_string(key)), value } end)
  end

end
