defmodule ElixirMunichWeb.PageControllerTest do
  use ElixirMunichWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    response = html_response(conn, 200)
    assert response =~ "Elixir & Erlang"
    assert response =~ "Welcome to Elixir & Erlang Munich"
    assert response =~ "Join our vibrant community"
  end
end
