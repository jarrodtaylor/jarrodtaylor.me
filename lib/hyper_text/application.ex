defmodule HyperText.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HyperTextWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:hyper_text, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HyperText.PubSub},
      HyperTextWeb.Endpoint,
      HyperText.Weblog.Repo
    ]
    
    opts = [strategy: :one_for_one, name: HyperText.Supervisor]
    Supervisor.start_link(children, opts)
  end
  
  @impl true
  def config_change(changed, _new, removed) do
    HyperTextWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end