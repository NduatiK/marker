defmodule GoldenWeb.PageController do
  use GoldenWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
