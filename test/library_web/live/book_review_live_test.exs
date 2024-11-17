defmodule LibraryWeb.BookReviewLiveTest do
  use LibraryWeb.ConnCase

  import Phoenix.LiveViewTest
  import Library.BooksFixtures

  @create_attrs %{patron_id: 42, book_id: 42, rating: 42, review_text: "some review_text"}
  @update_attrs %{patron_id: 43, book_id: 43, rating: 43, review_text: "some updated review_text"}
  @invalid_attrs %{patron_id: nil, book_id: nil, rating: nil, review_text: nil}

  defp create_book_review(_) do
    book_review = book_review_fixture()
    %{book_review: book_review}
  end

  describe "Index" do
    setup [:create_book_review]

    test "lists all book_reviews", %{conn: conn, book_review: book_review} do
      {:ok, _index_live, html} = live(conn, ~p"/book_reviews")

      assert html =~ "Listing Book reviews"
      assert html =~ book_review.review_text
    end

    test "saves new book_review", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/book_reviews")

      assert index_live |> element("a", "New Book review") |> render_click() =~
               "New Book review"

      assert_patch(index_live, ~p"/book_reviews/new")

      assert index_live
             |> form("#book_review-form", book_review: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#book_review-form", book_review: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/book_reviews")

      html = render(index_live)
      assert html =~ "Book review created successfully"
      assert html =~ "some review_text"
    end

    test "updates book_review in listing", %{conn: conn, book_review: book_review} do
      {:ok, index_live, _html} = live(conn, ~p"/book_reviews")

      assert index_live |> element("#book_reviews-#{book_review.id} a", "Edit") |> render_click() =~
               "Edit Book review"

      assert_patch(index_live, ~p"/book_reviews/#{book_review}/edit")

      assert index_live
             |> form("#book_review-form", book_review: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#book_review-form", book_review: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/book_reviews")

      html = render(index_live)
      assert html =~ "Book review updated successfully"
      assert html =~ "some updated review_text"
    end

    test "deletes book_review in listing", %{conn: conn, book_review: book_review} do
      {:ok, index_live, _html} = live(conn, ~p"/book_reviews")

      assert index_live
             |> element("#book_reviews-#{book_review.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#book_reviews-#{book_review.id}")
    end
  end

  describe "Show" do
    setup [:create_book_review]

    test "displays book_review", %{conn: conn, book_review: book_review} do
      {:ok, _show_live, html} = live(conn, ~p"/book_reviews/#{book_review}")

      assert html =~ "Show Book review"
      assert html =~ book_review.review_text
    end

    test "updates book_review within modal", %{conn: conn, book_review: book_review} do
      {:ok, show_live, _html} = live(conn, ~p"/book_reviews/#{book_review}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Book review"

      assert_patch(show_live, ~p"/book_reviews/#{book_review}/show/edit")

      assert show_live
             |> form("#book_review-form", book_review: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#book_review-form", book_review: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/book_reviews/#{book_review}")

      html = render(show_live)
      assert html =~ "Book review updated successfully"
      assert html =~ "some updated review_text"
    end
  end
end
