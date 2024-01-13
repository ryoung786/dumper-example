defmodule Library.Patrons do
  @moduledoc """
  The Patrons context.
  """

  import Ecto.Query, warn: false
  alias Library.Repo

  alias Library.Patrons.Patron

  @doc """
  Returns the list of patrons.

  ## Examples

      iex> list_patrons()
      [%Patron{}, ...]

  """
  def list_patrons do
    Repo.all(Patron)
  end

  @doc """
  Gets a single patron.

  Raises `Ecto.NoResultsError` if the Patron does not exist.

  ## Examples

      iex> get_patron!(123)
      %Patron{}

      iex> get_patron!(456)
      ** (Ecto.NoResultsError)

  """
  def get_patron!(id), do: Repo.get!(Patron, id)

  @doc """
  Creates a patron.

  ## Examples

      iex> create_patron(%{field: value})
      {:ok, %Patron{}}

      iex> create_patron(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_patron(attrs \\ %{}) do
    %Patron{}
    |> Patron.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a patron.

  ## Examples

      iex> update_patron(patron, %{field: new_value})
      {:ok, %Patron{}}

      iex> update_patron(patron, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_patron(%Patron{} = patron, attrs) do
    patron
    |> Patron.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a patron.

  ## Examples

      iex> delete_patron(patron)
      {:ok, %Patron{}}

      iex> delete_patron(patron)
      {:error, %Ecto.Changeset{}}

  """
  def delete_patron(%Patron{} = patron) do
    Repo.delete(patron)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking patron changes.

  ## Examples

      iex> change_patron(patron)
      %Ecto.Changeset{data: %Patron{}}

  """
  def change_patron(%Patron{} = patron, attrs \\ %{}) do
    Patron.changeset(patron, attrs)
  end
end
