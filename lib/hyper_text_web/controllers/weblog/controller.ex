defmodule HyperTextWeb.WeblogController do
	use HyperTextWeb, :controller

	alias HyperText.Weblog.Repo

	def recents(conn, _params) do
		render(conn, :articles, articles: Repo.recents, style: "weblog articles")
	end

	def index(conn, _params) do
		render(conn, :index, articles: Repo.index, page_title: "Weblog", style: "weblog index")
	end

	def archive(conn, %{"year" => year, "month" => month}) do
		page_title_date = Date.from_iso8601!("#{year}-#{month}-01") |> Calendar.strftime("%b %Y")
		render(conn, :articles, articles: Repo.archive(year, month), page_title: "Weblog ∈ #{page_title_date}", style: "weblog articles")
	end

	def column(conn, _params), do: render(conn, :slug)
	def linked(conn, _params), do: render(conn, :slug)
end