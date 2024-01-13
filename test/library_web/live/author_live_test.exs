defmodule LibraryWeb.AuthorLiveTest do
  use LibraryWeb.ConnCase

  import Phoenix.LiveViewTest
  import Library.AuthorsFixtures

  @create_attrs %{first_name: "some first_name", last_name: "some last_name", date_of_birth: "2024-01-12"}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", date_of_birth: "2024-01-13"}
  @invalid_attrs %{first_name: nil, last_name: nil, date_of_birth: nil}

  defp create_author(_) do
    author = author_fixture()
    %{author: author}
  end

  describe "Index" do
    setup [:create_author]

    test "lists all authors", %{conn: conn, author: author} do
      {:ok, _index_live, html} = live(conn, ~p"/authors")

      assert html =~ "Listing Authors"
      assert html =~ author.first_name
    end

    test "saves new author", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/authors")

      assert index_live |> element("a", "New Author") |> render_click() =~
               "New Author"

      assert_patch(index_live, ~p"/authors/new")

      assert index_live
             |> form("#author-form", author: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#author-form", author: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/authors")

      html = render(index_live)
      assert html =~ "Author created successfully"
      assert html =~ "some first_name"
    end

    test "updates author in listing", %{conn: conn, author: author} do
      {:ok, index_live, _html} = live(conn, ~p"/authors")

      assert index_live |> element("#authors-#{author.id} a", "Edit") |> render_click() =~
               "Edit Author"

      assert_patch(index_live, ~p"/authors/#{author}/edit")

      assert index_live
             |> form("#author-form", author: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#author-form", author: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/authors")

      html = render(index_live)
      assert html =~ "Author updated successfully"
      assert html =~ "some updated first_name"
    end

    test "deletes author in listing", %{conn: conn, author: author} do
      {:ok, index_live, _html} = live(conn, ~p"/authors")

      assert index_live |> element("#authors-#{author.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#authors-#{author.id}")
    end
  end

  describe "Show" do
    setup [:create_author]

    test "displays author", %{conn: conn, author: author} do
      {:ok, _show_live, html} = live(conn, ~p"/authors/#{author}")

      assert html =~ "Show Author"
      assert html =~ author.first_name
    end

    test "updates author within modal", %{conn: conn, author: author} do
      {:ok, show_live, _html} = live(conn, ~p"/authors/#{author}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Author"

      assert_patch(show_live, ~p"/authors/#{author}/show/edit")

      assert show_live
             |> form("#author-form", author: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#author-form", author: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/authors/#{author}")

      html = render(show_live)
      assert html =~ "Author updated successfully"
      assert html =~ "some updated first_name"
    end
  end
end
