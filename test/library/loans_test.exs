defmodule Library.LoansTest do
  use Library.DataCase

  alias Library.Loans

  describe "loans" do
    alias Library.Loans.Loan

    import Library.LoansFixtures

    @invalid_attrs %{patron_id: nil, book_id: nil, borrowed_at: nil, returned_at: nil}

    test "list_loans/0 returns all loans" do
      loan = loan_fixture()
      assert Loans.list_loans() == [loan]
    end

    test "get_loan!/1 returns the loan with given id" do
      loan = loan_fixture()
      assert Loans.get_loan!(loan.id) == loan
    end

    test "create_loan/1 with valid data creates a loan" do
      valid_attrs = %{
        patron_id: 42,
        book_id: 42,
        borrowed_at: ~U[2024-01-12 02:17:00Z],
        returned_at: ~U[2024-01-12 02:17:00Z],
        due_at: ~U[2024-01-14 02:17:00Z]
      }

      assert {:ok, %Loan{} = loan} = Loans.create_loan(valid_attrs)
      assert loan.patron_id == 42
      assert loan.book_id == 42
      assert loan.borrowed_at == ~U[2024-01-12 02:17:00Z]
      assert loan.returned_at == ~U[2024-01-12 02:17:00Z]
    end

    test "create_loan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Loans.create_loan(@invalid_attrs)
    end

    test "update_loan/2 with valid data updates the loan" do
      loan = loan_fixture()

      update_attrs = %{
        patron_id: 43,
        book_id: 43,
        borrowed_at: ~U[2024-01-13 02:17:00Z],
        returned_at: ~U[2024-01-13 02:17:00Z]
      }

      assert {:ok, %Loan{} = loan} = Loans.update_loan(loan, update_attrs)
      assert loan.patron_id == 43
      assert loan.book_id == 43
      assert loan.borrowed_at == ~U[2024-01-13 02:17:00Z]
      assert loan.returned_at == ~U[2024-01-13 02:17:00Z]
    end

    test "update_loan/2 with invalid data returns error changeset" do
      loan = loan_fixture()
      assert {:error, %Ecto.Changeset{}} = Loans.update_loan(loan, @invalid_attrs)
      assert loan == Loans.get_loan!(loan.id)
    end

    test "delete_loan/1 deletes the loan" do
      loan = loan_fixture()
      assert {:ok, %Loan{}} = Loans.delete_loan(loan)
      assert_raise Ecto.NoResultsError, fn -> Loans.get_loan!(loan.id) end
    end

    test "change_loan/1 returns a loan changeset" do
      loan = loan_fixture()
      assert %Ecto.Changeset{} = Loans.change_loan(loan)
    end
  end
end
