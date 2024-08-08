defmodule HyperTextWeb.PageController do
  use HyperTextWeb, :controller

  def readme(conn, _params), do: render(conn, :readme)
end