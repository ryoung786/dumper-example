defmodule Library.LoansFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Library.Loans` context.
  """

  @doc """
  Generate a loan.
  """
  def loan_fixture(attrs \\ %{}) do
    {:ok, loan} =
      attrs
      |> Enum.into(%{
        book_id: 42,
        borrowed_at: ~U[2024-01-12 02:17:00Z],
        patron_id: 42,
        returned_at: ~U[2024-01-13 02:17:00Z],
        due_at: ~U[2024-01-15 02:17:00Z]
      })
      |> Library.Loans.create_loan()

    loan
  end
end
