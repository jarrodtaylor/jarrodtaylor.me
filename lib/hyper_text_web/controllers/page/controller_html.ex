defmodule HyperTextWeb.PageController do
  use HyperTextWeb, :controller
  def readme(conn, _params), do: render(conn, :readme)
end

defmodule HyperTextWeb.PageHTML do
  use HyperTextWeb, :html
  embed_templates "templates/*"
end