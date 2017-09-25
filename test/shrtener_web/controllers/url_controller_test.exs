defmodule ShrtenerWeb.UrlControllerTest do
  use ShrtenerWeb.ConnCase

  @create_attrs %{url: "http://google.com/"}
  @invalid_attrs %{url: "some url"}

  describe "new url" do
    test "renders form", %{conn: conn} do
      conn = get conn, url_path(conn, :new)
      assert html_response(conn, 200) =~ "New Url"
    end
  end

  describe "create url" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, url_path(conn, :create), url: @create_attrs

      # TODO: Redirect to show action
      assert %{} = redirected_params(conn)
      assert redirected_to(conn) == url_path(conn, :new)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, url_path(conn, :create), url: @invalid_attrs
      assert html_response(conn, 200) =~ "New Url"
    end
  end
end
