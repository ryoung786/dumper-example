defmodule LibraryWeb.DumperConfig do
  @moduledoc """
  The library user defines this module themselves - it's not part of the dumper library.

  They set it in the :dumper config
  """

  use Dumper.Config

  @impl Dumper.Config
  def ids_to_schema() do
    %{
      patron_id: Library.Patrons.Patron,
      book_id: Library.Books.Book,
      author_id: Library.Authors.Author
    }
  end

  @impl Dumper.Config
  def display(%{field: :last_name} = assigns) do
    ~H"""
    <span style="color: red"><%= @value %></span>
    """
  end

  @impl Dumper.Config
  def custom_record_links(%Library.Books.Book{} = book) do
    [{"https://goodreads.com/search?q=#{book.title}", "Goodreads"}, {"#", "Logs"}]
  end
end
