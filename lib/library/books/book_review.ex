defmodule Library.Books.BookReview do
  use Ecto.Schema
  import Ecto.Changeset

  alias Library.Books.Book
  alias Library.Patrons.Patron

  schema "book_reviews" do
    field :rating, :integer
    field :review_text, :string

    belongs_to :patron, Patron
    belongs_to :book, Book

    timestamps()
  end

  @doc false
  def changeset(book_review, attrs) do
    book_review
    |> cast(attrs, [:patron_id, :book_id, :rating, :review_text])
    |> validate_required([:patron_id, :book_id, :rating, :review_text])
  end
end
