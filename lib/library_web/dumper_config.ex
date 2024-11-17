defmodule LibraryWeb.DumperConfig do
  @moduledoc """
  Customize the Dumper.
  """

  use Dumper.Config

  @impl Dumper.Config
  def ids_to_schema() do
    # everywhere we render a field named "patron_id" etc, the id will be transformed
    # into a clickable link to view that specific record
    %{
      patron_id: Library.Patrons.Patron,
      book_id: Library.Books.Book,
      author_id: Library.Authors.Author
    }
  end

  @impl Dumper.Config
  def display(%{field: :last_name} = assigns) do
    # Make all "last_name"s red
    ~H"""
    <span style="color: red"><%= @value %></span>
    """
  end

  @impl Dumper.Config
  def custom_record_links(%Library.Books.Book{} = book) do
    # When rendering a Book, display a link to Goodreads and a link to the logs
    [{"https://goodreads.com/search?q=#{book.title}", "Goodreads"}, {"#", "Logs"}]
  end
end
