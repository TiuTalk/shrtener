defmodule ShrtenerWeb.PageController do
  use ShrtenerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
