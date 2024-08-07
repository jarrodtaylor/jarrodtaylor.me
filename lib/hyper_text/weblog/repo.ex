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
	
	def recents do
		(fn ->
			__MODULE__.all
			|> Enum.take(100)
			|> Enum.group_by(&(DateTime.to_date(&1.published)))
			|> Enum.reverse
		end)
		|> cache(:recents)
	end
	
	def index do
		(fn ->
			__MODULE__.all
			|> Enum.filter(&(&1.source == nil))
			|> Enum.map(fn article ->
				%{
					slug: article.slug,
					title: article.title,
					published: article.published,
					updated: article.updated,
				}
			end)
			|> Enum.group_by(&(Date.beginning_of_month(&1.published)))
			|> Enum.reverse
		end)
		|> cache(:index)
	end
	
	def archive(year, month) do
		__MODULE__.all
		|> Enum.filter(&(Calendar.strftime(&1.published, "%Y-%m") == "#{year}-#{month}"))
		|> Enum.group_by(&(DateTime.to_date(&1.published)))
		|> Enum.reverse
	end
end