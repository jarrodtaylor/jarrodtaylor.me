defmodule HyperTextWeb.Router do
  use HyperTextWeb, :router

  @cache_control_policy Application.compile_env(:hyper_text, :cache_control, "public, max-age=3600")

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HyperTextWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_cache_control_policy
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HyperTextWeb do
    pipe_through :browser

    get "/", WeblogController, :recents

    get "/readme", PageController, :readme

    get "/weblog", WeblogController, :index
    get "/weblog/archive/:year/:month", WeblogController, :archive
    get "/weblog/linked/:year/:month/:slug", WeblogController, :linked
    get "/weblog/:year/:month/:slug", WeblogController, :column
  end

  # Other scopes may use custom stacks.
  # scope "/api", HyperTextWeb do
  #   pipe_through :api
  # end

  if Application.compile_env(:hyper_text, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: HyperTextWeb.Telemetry
    end
  end

  defp put_cache_control_policy(conn, _opts) do
    put_resp_header(conn, "cache-control", @cache_control_policy)
  end
end