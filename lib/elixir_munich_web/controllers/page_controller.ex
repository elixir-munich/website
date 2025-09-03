defmodule ElixirMunichWeb.PageController do
  use ElixirMunichWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
