defmodule Library.Books do
  @moduledoc """
  The Books context.
  """

  import Ecto.Query, warn: false
  alias Library.Repo

  alias Library.Books.Book

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id), do: Repo.get!(Book, id)

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.

  ## Examples

      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}

      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{data: %Book{}}

  """
  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end

  alias Library.Books.BookReview

  @doc """
  Returns the list of book_reviews.

  ## Examples

      iex> list_book_reviews()
      [%BookReview{}, ...]

  """
  def list_book_reviews do
    Repo.all(BookReview)
  end

  @doc """
  Gets a single book_review.

  Raises `Ecto.NoResultsError` if the Book review does not exist.

  ## Examples

      iex> get_book_review!(123)
      %BookReview{}

      iex> get_book_review!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book_review!(id), do: Repo.get!(BookReview, id)

  @doc """
  Creates a book_review.

  ## Examples

      iex> create_book_review(%{field: value})
      {:ok, %BookReview{}}

      iex> create_book_review(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book_review(attrs \\ %{}) do
    %BookReview{}
    |> BookReview.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book_review.

  ## Examples

      iex> update_book_review(book_review, %{field: new_value})
      {:ok, %BookReview{}}

      iex> update_book_review(book_review, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book_review(%BookReview{} = book_review, attrs) do
    book_review
    |> BookReview.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a book_review.

  ## Examples

      iex> delete_book_review(book_review)
      {:ok, %BookReview{}}

      iex> delete_book_review(book_review)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book_review(%BookReview{} = book_review) do
    Repo.delete(book_review)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book_review changes.

  ## Examples

      iex> change_book_review(book_review)
      %Ecto.Changeset{data: %BookReview{}}

  """
  def change_book_review(%BookReview{} = book_review, attrs \\ %{}) do
    BookReview.changeset(book_review, attrs)
  end
end
