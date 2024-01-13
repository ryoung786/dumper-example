defmodule Library.Authors.Author do
  use Ecto.Schema
  import Ecto.Changeset

  alias Library.Books.Book

  schema "authors" do
    field :first_name, :string
    field :last_name, :string
    field :date_of_birth, :date

    has_many :books, Book

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:first_name, :last_name, :date_of_birth])
    |> validate_required([:first_name, :last_name, :date_of_birth])
  end
end
