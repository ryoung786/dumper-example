defmodule Library.BooksTest do
  use Library.DataCase

  alias Library.Books

  describe "books" do
    alias Library.Books.Book

    import Library.BooksFixtures

    @invalid_attrs %{title: nil, author_id: nil, published_at: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Books.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Books.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{
        title: "some title",
        author_id: 1,
        published_at: ~D[2024-01-12]
      }

      assert {:ok, %Book{} = book} = Books.create_book(valid_attrs)
      assert book.title == "some title"
      assert book.author_id == 1
      assert book.published_at == ~D[2024-01-12]
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Books.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()

      update_attrs = %{
        title: "some updated title",
        author_id: 2,
        published_at: ~D[2024-01-13]
      }

      assert {:ok, %Book{} = book} = Books.update_book(book, update_attrs)
      assert book.title == "some updated title"
      assert book.author_id == 2
      assert book.published_at == ~D[2024-01-13]
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Books.update_book(book, @invalid_attrs)
      assert book == Books.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Books.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Books.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Books.change_book(book)
    end
  end

  describe "book_reviews" do
    alias Library.Books.BookReview

    import Library.BooksFixtures

    @invalid_attrs %{patron_id: nil, book_id: nil, rating: nil, review_text: nil}

    test "list_book_reviews/0 returns all book_reviews" do
      book_review = book_review_fixture()
      assert Books.list_book_reviews() == [book_review]
    end

    test "get_book_review!/1 returns the book_review with given id" do
      book_review = book_review_fixture()
      assert Books.get_book_review!(book_review.id) == book_review
    end

    test "create_book_review/1 with valid data creates a book_review" do
      valid_attrs = %{patron_id: 42, book_id: 42, rating: 42, review_text: "some review_text"}

      assert {:ok, %BookReview{} = book_review} = Books.create_book_review(valid_attrs)
      assert book_review.patron_id == 42
      assert book_review.book_id == 42
      assert book_review.rating == 42
      assert book_review.review_text == "some review_text"
    end

    test "create_book_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Books.create_book_review(@invalid_attrs)
    end

    test "update_book_review/2 with valid data updates the book_review" do
      book_review = book_review_fixture()

      update_attrs = %{
        patron_id: 43,
        book_id: 43,
        rating: 43,
        review_text: "some updated review_text"
      }

      assert {:ok, %BookReview{} = book_review} =
               Books.update_book_review(book_review, update_attrs)

      assert book_review.patron_id == 43
      assert book_review.book_id == 43
      assert book_review.rating == 43
      assert book_review.review_text == "some updated review_text"
    end

    test "update_book_review/2 with invalid data returns error changeset" do
      book_review = book_review_fixture()
      assert {:error, %Ecto.Changeset{}} = Books.update_book_review(book_review, @invalid_attrs)
      assert book_review == Books.get_book_review!(book_review.id)
    end

    test "delete_book_review/1 deletes the book_review" do
      book_review = book_review_fixture()
      assert {:ok, %BookReview{}} = Books.delete_book_review(book_review)
      assert_raise Ecto.NoResultsError, fn -> Books.get_book_review!(book_review.id) end
    end

    test "change_book_review/1 returns a book_review changeset" do
      book_review = book_review_fixture()
      assert %Ecto.Changeset{} = Books.change_book_review(book_review)
    end
  end
end
