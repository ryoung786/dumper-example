defmodule Library.PatronsTest do
  use Library.DataCase

  alias Library.Patrons

  describe "patrons" do
    alias Library.Patrons.Patron

    import Library.PatronsFixtures

    @invalid_attrs %{
      first_name: nil,
      last_name: nil,
      date_of_birth: nil,
      email_address: nil,
      late_fees_balance: nil
    }

    test "list_patrons/0 returns all patrons" do
      patron = patron_fixture()
      assert Patrons.list_patrons() == [patron]
    end

    test "get_patron!/1 returns the patron with given id" do
      patron = patron_fixture()
      assert Patrons.get_patron!(patron.id) == patron
    end

    test "create_patron/1 with valid data creates a patron" do
      valid_attrs = %{
        first_name: "some first_name",
        last_name: "some last_name",
        date_of_birth: ~D[2024-01-12],
        email_address: "some email_address",
        late_fees_balance: 42
      }

      assert {:ok, %Patron{} = patron} = Patrons.create_patron(valid_attrs)
      assert patron.first_name == "some first_name"
      assert patron.last_name == "some last_name"
      assert patron.date_of_birth == ~D[2024-01-12]
      assert patron.email_address == "some email_address"
      assert patron.late_fees_balance == 42
    end

    test "create_patron/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Patrons.create_patron(@invalid_attrs)
    end

    test "update_patron/2 with valid data updates the patron" do
      patron = patron_fixture()

      update_attrs = %{
        first_name: "some updated first_name",
        last_name: "some updated last_name",
        date_of_birth: ~D[2024-01-13],
        email_address: "some updated email_address",
        late_fees_balance: 43
      }

      assert {:ok, %Patron{} = patron} = Patrons.update_patron(patron, update_attrs)
      assert patron.first_name == "some updated first_name"
      assert patron.last_name == "some updated last_name"
      assert patron.date_of_birth == ~D[2024-01-13]
      assert patron.email_address == "some updated email_address"
      assert patron.late_fees_balance == 43
    end

    test "update_patron/2 with invalid data returns error changeset" do
      patron = patron_fixture()
      assert {:error, %Ecto.Changeset{}} = Patrons.update_patron(patron, @invalid_attrs)
      assert patron == Patrons.get_patron!(patron.id)
    end

    test "delete_patron/1 deletes the patron" do
      patron = patron_fixture()
      assert {:ok, %Patron{}} = Patrons.delete_patron(patron)
      assert_raise Ecto.NoResultsError, fn -> Patrons.get_patron!(patron.id) end
    end

    test "change_patron/1 returns a patron changeset" do
      patron = patron_fixture()
      assert %Ecto.Changeset{} = Patrons.change_patron(patron)
    end
  end
end
