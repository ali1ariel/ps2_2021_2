defmodule BlackCatWeb.PageController do
  use BlackCatWeb, :controller

  plug :put_layout, "app.html"

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
