defmodule Library.AuthorsTest do
  use Library.DataCase

  alias Library.Authors

  describe "authors" do
    alias Library.Authors.Author

    import Library.AuthorsFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, date_of_birth: nil}

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Authors.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Authors.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      valid_attrs = %{
        first_name: "some first_name",
        last_name: "some last_name",
        date_of_birth: ~D[2024-01-12]
      }

      assert {:ok, %Author{} = author} = Authors.create_author(valid_attrs)
      assert author.first_name == "some first_name"
      assert author.last_name == "some last_name"
      assert author.date_of_birth == ~D[2024-01-12]
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authors.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()

      update_attrs = %{
        first_name: "some updated first_name",
        last_name: "some updated last_name",
        date_of_birth: ~D[2024-01-13]
      }

      assert {:ok, %Author{} = author} = Authors.update_author(author, update_attrs)
      assert author.first_name == "some updated first_name"
      assert author.last_name == "some updated last_name"
      assert author.date_of_birth == ~D[2024-01-13]
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Authors.update_author(author, @invalid_attrs)
      assert author == Authors.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Authors.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Authors.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Authors.change_author(author)
    end
  end
end
