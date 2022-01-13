defmodule BlackCatWeb.UserController do
  use BlackCatWeb, :controller

  alias BlackCat.Accounts
  alias BlackCatWeb.UserAuth

  plug :put_layout, "root.html"


  def index(conn, _params) do
    users = BlackCat.Accounts.list_users
    render(conn, "index.html", users: users)
  end


  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "Usuário deletado com sucesso.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
