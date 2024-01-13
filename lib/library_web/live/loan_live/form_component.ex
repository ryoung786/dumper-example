defmodule LibraryWeb.LoanLive.FormComponent do
  use LibraryWeb, :live_component

  alias Library.Loans

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage loan records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="loan-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:patron_id]} type="number" label="Patron" />
        <.input field={@form[:book_id]} type="number" label="Book" />
        <.input field={@form[:borrowed_at]} type="datetime-local" label="Borrowed at" />
        <.input field={@form[:due_at]} type="datetime-local" label="Due at" />
        <.input field={@form[:returned_at]} type="datetime-local" label="Returned at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Loan</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{loan: loan} = assigns, socket) do
    changeset = Loans.change_loan(loan)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"loan" => loan_params}, socket) do
    changeset =
      socket.assigns.loan
      |> Loans.change_loan(loan_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"loan" => loan_params}, socket) do
    save_loan(socket, socket.assigns.action, loan_params)
  end

  defp save_loan(socket, :edit, loan_params) do
    case Loans.update_loan(socket.assigns.loan, loan_params) do
      {:ok, loan} ->
        notify_parent({:saved, loan})

        {:noreply,
         socket
         |> put_flash(:info, "Loan updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_loan(socket, :new, loan_params) do
    case Loans.create_loan(loan_params) do
      {:ok, loan} ->
        notify_parent({:saved, loan})

        {:noreply,
         socket
         |> put_flash(:info, "Loan created successfully")
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
