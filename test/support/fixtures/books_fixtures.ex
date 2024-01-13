defmodule Library.BooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Library.Books` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        author_id: 1,
        published_at: ~D[2024-01-12],
        title: "some title"
      })
      |> Library.Books.create_book()

    book
  end

  @doc """
  Generate a book_review.
  """
  def book_review_fixture(attrs \\ %{}) do
    {:ok, book_review} =
      attrs
      |> Enum.into(%{
        book_id: 42,
        patron_id: 42,
        rating: 42,
        review_text: "some review_text"
      })
      |> Library.Books.create_book_review()

    book_review
  end
end
