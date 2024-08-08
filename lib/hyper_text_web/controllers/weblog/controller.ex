defmodule HyperTextWeb.WeblogController do
	use HyperTextWeb, :controller

	alias HyperText.Weblog.Repo

	def recents(conn, _params) do
		conn
		|> render(:articles,
			articles: Repo.recents,
			style: "weblog articles")
	end

	def index(conn, _params) do
		conn
		|> render(:index,
			articles: Repo.index,
			page_title: "Weblog",
			style: "weblog index")
	end

	def archive(conn, %{"year" => year, "month" => month}) do
		conn
		|> render(:articles,
			articles: Repo.archive(year, month),
			page_title: "Weblog ∈ " <> (Date.from_iso8601!("#{year}-#{month}-01") |> Calendar.strftime("%b %Y")),
			style: "weblog articles")
	end

	def column(conn, %{"year" => year, "month" => month, "slug" => slug}) do
		article = Repo.slug("weblog/#{year}/#{month}/#{slug}")

		conn
		|> render(:slug,
			article: article,
			page_title: "#{article.title}",
			style: "weblog article")
	end

	def linked(conn, %{"year" => year, "month" => month, "slug" => slug}) do
		article = Repo.slug("weblog/linked/#{year}/#{month}/#{slug}")

		conn
		|> render(:slug,
			article: article,
			page_title: "#{article.title}",
			style: "weblog article")
	end
end