defmodule BlackCatWeb.PageController do
  use BlackCatWeb, :controller

  plug :put_layout, "root.html"

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
