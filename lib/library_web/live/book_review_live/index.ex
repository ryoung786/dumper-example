defmodule LibraryWeb.BookReviewLive.Index do
  use LibraryWeb, :live_view

  alias Library.Books
  alias Library.Books.BookReview

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :book_reviews, Books.list_book_reviews())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Book review")
    |> assign(:book_review, Books.get_book_review!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Book review")
    |> assign(:book_review, %BookReview{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Book reviews")
    |> assign(:book_review, nil)
  end

  @impl true
  def handle_info({LibraryWeb.BookReviewLive.FormComponent, {:saved, book_review}}, socket) do
    {:noreply, stream_insert(socket, :book_reviews, book_review)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    book_review = Books.get_book_review!(id)
    {:ok, _} = Books.delete_book_review(book_review)

    {:noreply, stream_delete(socket, :book_reviews, book_review)}
  end
end
