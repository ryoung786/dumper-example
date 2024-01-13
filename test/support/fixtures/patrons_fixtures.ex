defmodule Library.PatronsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Library.Patrons` context.
  """

  @doc """
  Generate a patron.
  """
  def patron_fixture(attrs \\ %{}) do
    {:ok, patron} =
      attrs
      |> Enum.into(%{
        date_of_birth: ~D[2024-01-12],
        email_address: "some email_address",
        first_name: "some first_name",
        last_name: "some last_name",
        late_fees_balance: 42
      })
      |> Library.Patrons.create_patron()

    patron
  end
end
