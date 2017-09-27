defmodule ShrtenerWeb.UrlControllerTest do
  use ShrtenerWeb.ConnCase

  @create_attrs %{url: "http://google.com/"}
  @invalid_attrs %{url: "some url"}

  describe "new url" do
    test "renders form", %{conn: conn} do
      conn = get conn, url_path(conn, :new)
      assert html_response(conn, 200) =~ "Paste a link"
    end
  end

  describe "create url" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, url_path(conn, :create), url: @create_attrs

      assert html_response(conn, 200) =~ "Paste a link"
      assert html_response(conn, 200) =~ "Here is your new URL"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, url_path(conn, :create), url: @invalid_attrs
      assert html_response(conn, 200) =~ "Paste a link"
      assert html_response(conn, 200) =~ "is not a valid URL"
    end
  end
end
