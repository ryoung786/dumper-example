defmodule Library.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias Library.Authors.Author
  alias Library.Books.BookReview

  schema "books" do
    field :title, :string
    field :published_at, :date

    belongs_to :author, Author
    has_many :reviews, BookReview

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author_id, :published_at])
    |> validate_required([:title, :author_id, :published_at])
  end
end
