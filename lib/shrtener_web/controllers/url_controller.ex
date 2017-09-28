defmodule ShrtenerWeb.UrlController do
  use ShrtenerWeb, :controller

  alias Shrtener.Shortener
  alias Shrtener.Shortener.Url

  def new(conn, _params) do
    changeset = Shortener.change_url(%Url{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"url" => url_params}) do
    case Shortener.create_url(url_params) do
      {:ok, url} ->
        changeset = Shortener.change_url(%Url{})
        render(conn, "new.html", changeset: changeset, url: url)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def redirect_shortcode(conn, %{"shortcode" => shortcode}) do
    url = Shortener.get_url_by_shortcode!(shortcode)

    case Shortener.increment_visits(url) do
      {:ok, url} ->
        redirect(conn, external: url.url)
      {:error, %Ecto.Changeset{} = _changeset} ->
        redirect(conn, to: url_path(conn, :new))
    end

  rescue
    Ecto.NoResultsError -> redirect(conn, to: url_path(conn, :new))
  end
end
