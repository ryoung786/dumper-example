defmodule Library.Repo.Migrations.CreateLibrary do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :author_id, :integer
      add :published_at, :date

      timestamps()
    end

    create table(:authors) do
      add :first_name, :string
      add :last_name, :string
      add :date_of_birth, :date

      timestamps()
    end
  end
end
