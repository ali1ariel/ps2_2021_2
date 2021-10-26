defmodule BlackCatWeb.PageController do
  use BlackCatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
