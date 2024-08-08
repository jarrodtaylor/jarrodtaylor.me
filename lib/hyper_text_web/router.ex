defmodule HyperTextWeb.Router do
  use HyperTextWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HyperTextWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HyperTextWeb do
    pipe_through :browser

    get "/readme", PageController, :readme
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
end