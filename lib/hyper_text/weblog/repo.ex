defmodule HyperText.Weblog.Repo do
	use GenServer
	
	alias HyperText.Weblog.Article, as: Article
	
	def start_link(_), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
	
	def init(args) do
		:ets.new(:weblog, [:set, :public, :named_table])
		{:ok, args}
	end
	
	defp cache(query, key) do
		case :ets.lookup(:weblog, key) do
			[] ->
				data = query.()
				:ets.insert(:weblog, {key, data})
				data
			
			[{_key, data}] -> data
		end
	end
	
	def all do
		(fn ->
			Path.wildcard("priv/weblog/**/*.md")
			|> Enum.map(&Article.compile/1)
			|> Enum.sort(&(&1.published >= &2.published))
		end)
		|> cache(:all)
	end
	
	def slug(slug), do: __MODULE__.all |> Enum.find(&(&1.slug == slug))
end