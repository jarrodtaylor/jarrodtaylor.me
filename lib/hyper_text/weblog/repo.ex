defmodule HyperText.Weblog.Repo do
	use GenServer
	
	def start_link(_), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
	
	def init(args) do
		:ets.new(:weblog, [:set, :private, :named_table])
		{:ok, args}
	end
end