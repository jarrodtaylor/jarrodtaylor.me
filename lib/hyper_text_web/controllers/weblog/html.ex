defmodule HyperTextWeb.WeblogHTML do
	use HyperTextWeb, :html

	def articles(assigns) do
		if assigns.articles == [] do
			~H"""
			<h2>Nothing to see here, move along.</h2>
			"""
		else
			~H"""
			<section :for={{date, articles} <- @articles}>
				<.time relative date={date} format={"%A %b %d, %Y"} />
				<.article :for={article <- articles} article={article} />
			</section>
			"""
		end
	end

	def index(assigns) do
		~H"""
		<section :for={{month, articles} <- @articles}>
			<.link href={"/weblog/archive/#{Calendar.strftime(month, "%Y/%m")}"}>
				<.time date={month} format={"%B %Y"} />
			</.link>
			<ul>
				<li :for={article <- articles}>
					<.link href={raw(article.slug)}><%= article.title %></.link>
					<.time relative date={article.published} format={"%b %d, %Y"} />
				</li>
			</ul>
		</section>
		"""
	end

	def slug(assigns) do
		~H"""
		<.article slug article={@article} />
		"""
	end

	defp article(assigns) do
		~H"""
		<article class={if @article.source, do: "link", else: "column"}>
			<h2 :if={@article.source}>
				<.link href={@article.source}><%= @article.title %></.link>
				<.link :if={!Map.has_key?(assigns, :slug)} href={@article.slug}>&#8734;</.link>
			</h2>
			<h2 :if={@article.source == nil && Map.has_key?(assigns, :slug)}>
				<%= @article.title %>
			</h2>
			<h2 :if={@article.source == nil && !Map.has_key?(assigns, :slug)}>
				<.link href={@article.slug}><%= @article.title %></.link>
			</h2>
			<.time :if={@article.source == nil} date={@article.published} format={"%b %d, %Y"} />
			<%= raw(@article.html) %>
		</article>
		"""
	end
end