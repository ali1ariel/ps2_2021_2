defmodule BlackCatWeb.AdmPageController do
  use BlackCatWeb, :controller

  plug :put_layout, "admin_app.html"

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
