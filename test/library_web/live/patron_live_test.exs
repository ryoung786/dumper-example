defmodule LibraryWeb.PatronLiveTest do
  use LibraryWeb.ConnCase

  import Phoenix.LiveViewTest
  import Library.PatronsFixtures

  @create_attrs %{
    first_name: "some first_name",
    last_name: "some last_name",
    date_of_birth: "2024-01-12",
    email_address: "some email_address",
    late_fees_balance: 42
  }
  @update_attrs %{
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    date_of_birth: "2024-01-13",
    email_address: "some updated email_address",
    late_fees_balance: 43
  }
  @invalid_attrs %{
    first_name: nil,
    last_name: nil,
    date_of_birth: nil,
    email_address: nil,
    late_fees_balance: nil
  }

  defp create_patron(_) do
    patron = patron_fixture()
    %{patron: patron}
  end

  describe "Index" do
    setup [:create_patron]

    test "lists all patrons", %{conn: conn, patron: patron} do
      {:ok, _index_live, html} = live(conn, ~p"/patrons")

      assert html =~ "Listing Patrons"
      assert html =~ patron.first_name
    end

    test "saves new patron", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/patrons")

      assert index_live |> element("a", "New Patron") |> render_click() =~
               "New Patron"

      assert_patch(index_live, ~p"/patrons/new")

      assert index_live
             |> form("#patron-form", patron: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#patron-form", patron: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/patrons")

      html = render(index_live)
      assert html =~ "Patron created successfully"
      assert html =~ "some first_name"
    end

    test "updates patron in listing", %{conn: conn, patron: patron} do
      {:ok, index_live, _html} = live(conn, ~p"/patrons")

      assert index_live |> element("#patrons-#{patron.id} a", "Edit") |> render_click() =~
               "Edit Patron"

      assert_patch(index_live, ~p"/patrons/#{patron}/edit")

      assert index_live
             |> form("#patron-form", patron: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#patron-form", patron: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/patrons")

      html = render(index_live)
      assert html =~ "Patron updated successfully"
      assert html =~ "some updated first_name"
    end

    test "deletes patron in listing", %{conn: conn, patron: patron} do
      {:ok, index_live, _html} = live(conn, ~p"/patrons")

      assert index_live |> element("#patrons-#{patron.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#patrons-#{patron.id}")
    end
  end

  describe "Show" do
    setup [:create_patron]

    test "displays patron", %{conn: conn, patron: patron} do
      {:ok, _show_live, html} = live(conn, ~p"/patrons/#{patron}")

      assert html =~ "Show Patron"
      assert html =~ patron.first_name
    end

    test "updates patron within modal", %{conn: conn, patron: patron} do
      {:ok, show_live, _html} = live(conn, ~p"/patrons/#{patron}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Patron"

      assert_patch(show_live, ~p"/patrons/#{patron}/show/edit")

      assert show_live
             |> form("#patron-form", patron: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#patron-form", patron: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/patrons/#{patron}")

      html = render(show_live)
      assert html =~ "Patron updated successfully"
      assert html =~ "some updated first_name"
    end
  end
end
