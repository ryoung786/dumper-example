defmodule Library.Repo.Migrations.CreatePatrons do
  use Ecto.Migration

  def change do
    create table(:patrons) do
      add :first_name, :string
      add :last_name, :string
      add :date_of_birth, :date
      add :email_address, :string
      add :late_fees_balance, :integer

      timestamps()
    end
  end
end
