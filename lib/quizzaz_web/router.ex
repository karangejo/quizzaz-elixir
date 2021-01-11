defmodule QuizzazWeb.Router do
  use QuizzazWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {QuizzazWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", QuizzazWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/games", GameLive.Index, :index
    live "/games/new", GameLive.Index, :new
    live "/games/:id/edit", GameLive.Index, :edit

    live "/games/:id", GameLive.Show, :show
    live "/games/:id/show/edit", GameLive.Show, :edit

    live "/questions", QuestionLive.Index, :index
    live "/questions/new", QuestionLive.Index, :new
    live "/questions/:id/edit", QuestionLive.Index, :edit

    live "/questions/:id", QuestionLive.Show, :show
    live "/questions/:id/show/edit", QuestionLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", QuizzazWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: QuizzazWeb.Telemetry
    end
  end
end