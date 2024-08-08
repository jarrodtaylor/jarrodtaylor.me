defmodule HyperTextWeb.WeblogController do
	use HyperTextWeb, :controller

	alias HyperText.Weblog.Repo

	def recents(conn, _params) do
		render(conn, :articles, articles: Repo.recents)
	end
	
	def index(conn, _params), do: render(conn, :index)
	def archive(conn, _params), do: render(conn, :archive)
	def column(conn, _params), do: render(conn, :slug)
	def linked(conn, _params), do: render(conn, :slug)
end