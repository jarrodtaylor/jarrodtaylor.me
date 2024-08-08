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
		Index
		"""
	end
	
	def archive(assigns) do
		~H"""
		Archive
		"""
	end
	
	def slug(assigns) do
		~H"""
		Slug
		"""
	end
	
	defp article(assigns) do
		~H"""
		<%= raw(@article.html) %>
		"""
	end
end