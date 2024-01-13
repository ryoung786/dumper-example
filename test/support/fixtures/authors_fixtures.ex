defmodule Library.AuthorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Library.Authors` context.
  """

  @doc """
  Generate a author.
  """
  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        date_of_birth: ~D[2024-01-12],
        first_name: "some first_name",
        last_name: "some last_name"
      })
      |> Library.Authors.create_author()

    author
  end
end
