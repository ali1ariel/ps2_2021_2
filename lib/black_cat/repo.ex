defmodule BlackCat.Repo do
  use Ecto.Repo,
    otp_app: :black_cat,
    adapter: Ecto.Adapters.Postgres
end
