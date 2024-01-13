defmodule Library.Loans.Loan do
  use Ecto.Schema
  import Ecto.Changeset

  alias Library.Books.Book
  alias Library.Patrons.Patron

  schema "loans" do
    field :borrowed_at, :utc_datetime
    field :returned_at, :utc_datetime
    field :due_at, :utc_datetime

    belongs_to :patron, Patron
    belongs_to :book, Book

    timestamps()
  end

  @doc false
  def changeset(loan, attrs) do
    loan
    |> cast(attrs, [:patron_id, :book_id, :borrowed_at, :returned_at, :due_at])
    |> validate_required([:patron_id, :book_id, :borrowed_at, :due_at])
  end
end
