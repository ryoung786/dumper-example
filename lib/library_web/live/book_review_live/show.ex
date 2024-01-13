defmodule LibraryWeb.BookReviewLive.Show do
  use LibraryWeb, :live_view

  alias Library.Books

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:book_review, Books.get_book_review!(id))}
  end

  defp page_title(:show), do: "Show Book review"
  defp page_title(:edit), do: "Edit Book review"
end
