defmodule Library.Patrons.Patron do
  use Ecto.Schema
  import Ecto.Changeset

  alias Library.Loans.Loan
  alias Library.Books.BookReview

  schema "patrons" do
    field :first_name, :string
    field :last_name, :string
    field :date_of_birth, :date
    field :email_address, :string
    field :late_fees_balance, :integer

    has_many :loans, Loan
    has_many :reviews, BookReview

    timestamps()
  end

  @doc false
  def changeset(patron, attrs) do
    patron
    |> cast(attrs, [:first_name, :last_name, :date_of_birth, :email_address, :late_fees_balance])
    |> validate_required([:first_name, :last_name, :date_of_birth, :email_address, :late_fees_balance])
  end
end
