defmodule TodosWeb.Router do
  use TodosWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/auth", TodosWeb do
    pipe_through :api

    post "/singup", AuthController, :create
    post "/signin", AuthController, :login
    get "/logout", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  scope "/api/todos", TodosWeb do
    pipe_through :api

    get "/", TodoController, :index
    get "/get/:id", TodoController, :get
    post "/create", TodoController, :create
    put "/update/:id", TodoController, :update
    delete "/delete/:id", TodoController, :delete
  end

  scope "/api/tables", TodosWeb do
    pipe_through :api

    get "/", TableController, :index
    get "/get/:id", TableController, :get
    post "/create", TableController, :create
    put "/todos", TableController, :add_todo
  end

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
      live_dashboard "/dashboard", metrics: TodosWeb.Telemetry
    end
  end
end
