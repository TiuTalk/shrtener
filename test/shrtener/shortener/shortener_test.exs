defmodule Shrtener.ShortenerTest do
  use Shrtener.DataCase

  alias Shrtener.Shortener

  describe "urls" do
    alias Shrtener.Shortener.Url

    @valid_attrs %{url: "http://google.com/"}
    @invalid_attrs %{url: "some url"}

    def url_fixture(attrs \\ %{}) do
      {:ok, url} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shortener.create_url()

      Shortener.get_url!(url.id)
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert Shortener.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      assert {:ok, %Url{} = url} = Shortener.create_url(@valid_attrs)
      assert url.url == "http://google.com/"
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortener.create_url(@invalid_attrs)
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = Shortener.change_url(url)
    end
  end
end
