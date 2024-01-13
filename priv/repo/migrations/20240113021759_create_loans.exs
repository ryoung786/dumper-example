defmodule Library.Repo.Migrations.CreateLoans do
  use Ecto.Migration

  def change do
    create table(:loans) do
      add :patron_id, :integer
      add :book_id, :integer
      add :borrowed_at, :utc_datetime
      add :returned_at, :utc_datetime
      add :due_at, :utc_datetime

      timestamps()
    end
  end
end
