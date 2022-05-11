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

  scope "/", TodosWeb do
    pipe_through :browser

    resources "/todos", TodoController
    get "/todos/get", TodoController, :get
    get "/", TodoController, :index

    resources "/tables", TableController
    put "/add_todo", TableController, :add_todo
  end

  scope "/auth", TodosWeb do
    pipe_through :browser

    get "/signup", AuthController, :create_show
    post "/singup", AuthController, :create

    get "/signin", AuthController, :login_show
    post "/signin", AuthController, :login
    
    get "/logout", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  scope "/api", TodosWeb do
    pipe_through :api

    get "/todos", TodoController, :index
    get "/todos/get", TodoController, :get

    post "/todos/create", TodoController, :create
    put "/todos/update/:id", TodoController, :update
    delete "/todos/delete/:id", TodoController, :delete
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
