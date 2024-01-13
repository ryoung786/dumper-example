defmodule LibraryWeb.BookReviewLive.FormComponent do
  use LibraryWeb, :live_component

  alias Library.Books

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage book_review records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="book_review-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:patron_id]} type="number" label="Patron" />
        <.input field={@form[:book_id]} type="number" label="Book" />
        <.input field={@form[:rating]} type="number" label="Rating" />
        <.input field={@form[:review_text]} type="text" label="Review text" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Book review</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{book_review: book_review} = assigns, socket) do
    changeset = Books.change_book_review(book_review)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"book_review" => book_review_params}, socket) do
    changeset =
      socket.assigns.book_review
      |> Books.change_book_review(book_review_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"book_review" => book_review_params}, socket) do
    save_book_review(socket, socket.assigns.action, book_review_params)
  end

  defp save_book_review(socket, :edit, book_review_params) do
    case Books.update_book_review(socket.assigns.book_review, book_review_params) do
      {:ok, book_review} ->
        notify_parent({:saved, book_review})

        {:noreply,
         socket
         |> put_flash(:info, "Book review updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_book_review(socket, :new, book_review_params) do
    case Books.create_book_review(book_review_params) do
      {:ok, book_review} ->
        notify_parent({:saved, book_review})

        {:noreply,
         socket
         |> put_flash(:info, "Book review created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
