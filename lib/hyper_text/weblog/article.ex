defmodule HyperText.Weblog.Article do
	defstruct [:slug, :title, :published, :updated, :source, :html]
	
	def compile(path) do
	{frontmatter, markdown} = parse_contents(path)
		
		%__MODULE__{
			slug: parse_slug(path),
			title: frontmatter |> lookup("title"),
			published: frontmatter |> lookup("published") |> parse_date,
			updated: frontmatter |> lookup("updated") |> parse_date,
			source: frontmatter |> lookup("source"),
			html: markdown |> Earmark.as_html!(sub_sup: true)
		}
	end
	
	defp lookup(frontmatter, key) do
		case :proplists.get_value(String.to_charlist(key), frontmatter) do
			:undefined -> nil
			value -> to_string(value)
		end
	end
		
	defp parse_contents(path) do
		[frontmatter, markdown] = path
		|> File.read!
		|> String.split("\n---\n", parts: 2)
		
		{
			frontmatter
			|> :yamerl_constr.string
			|> Enum.at(0),
			
			String.trim(markdown)
		}
	end
	
	defp parse_date(date) do
		case date do
			nil -> nil
			
			date ->
				date
				|> NaiveDateTime.from_iso8601!
				|> DateTime.from_naive!("America/New_York")
		end
	end
	
	defp parse_slug(path) do
		path
		|> String.replace("priv/", "")
		|> String.replace(".md", "")
	end
end