defmodule HyperTextWeb.WeblogHTML do
	use HyperTextWeb, :html
	
	def recents(assigns) do
		~H"""
		Recents
		"""
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
end