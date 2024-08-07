defmodule HyperText.Weblog.Repo do
	use GenServer
	
	alias HyperText.Weblog.Article, as: Article
	
	def start_link(_), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
	
	def init(args) do
		:ets.new(:weblog, [:set, :private, :named_table])
		{:ok, args}
	end
	
	def all do
		Path.wildcard("priv/weblog/**/*.md")
		|> Enum.map(&Article.compile/1)
		|> Enum.sort(&(&1.published >= &2.published))
	end
end