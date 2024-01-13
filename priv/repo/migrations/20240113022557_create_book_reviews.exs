defmodule Library.Repo.Migrations.CreateBookReviews do
  use Ecto.Migration

  def change do
    create table(:book_reviews) do
      add :patron_id, :integer
      add :book_id, :integer
      add :rating, :integer
      add :review_text, :text

      timestamps()
    end
  end
end
