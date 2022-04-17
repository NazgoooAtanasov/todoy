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

    get "/:provider", AuthController, :request
    get "/:provider/request", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end
end
