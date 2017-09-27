defmodule ShrtenerWeb.Router do
  use ShrtenerWeb, :router

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

  scope "/", ShrtenerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", UrlController, :new
    resources "/urls", UrlController, only: [:new, :create]
    get "/:shortcode", UrlController, :redirect_shortcode
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShrtenerWeb do
  #   pipe_through :api
  # end
end
