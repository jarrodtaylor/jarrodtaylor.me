defmodule HyperTextWeb.PageController do
  use HyperTextWeb, :controller
  def readme(conn, _params), do: render(conn, :readme, page_title: "README")
end

defmodule HyperTextWeb.PageHTML do
  use HyperTextWeb, :html
  embed_templates "templates/*"
end