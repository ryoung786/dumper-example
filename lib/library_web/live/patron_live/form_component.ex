defmodule LibraryWeb.PatronLive.FormComponent do
  use LibraryWeb, :live_component

  alias Library.Patrons

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage patron records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="patron-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:first_name]} type="text" label="First name" />
        <.input field={@form[:last_name]} type="text" label="Last name" />
        <.input field={@form[:date_of_birth]} type="date" label="Date of birth" />
        <.input field={@form[:email_address]} type="text" label="Email address" />
        <.input field={@form[:late_fees_balance]} type="number" label="Late fees balance" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Patron</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{patron: patron} = assigns, socket) do
    changeset = Patrons.change_patron(patron)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"patron" => patron_params}, socket) do
    changeset =
      socket.assigns.patron
      |> Patrons.change_patron(patron_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"patron" => patron_params}, socket) do
    save_patron(socket, socket.assigns.action, patron_params)
  end

  defp save_patron(socket, :edit, patron_params) do
    case Patrons.update_patron(socket.assigns.patron, patron_params) do
      {:ok, patron} ->
        notify_parent({:saved, patron})

        {:noreply,
         socket
         |> put_flash(:info, "Patron updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_patron(socket, :new, patron_params) do
    case Patrons.create_patron(patron_params) do
      {:ok, patron} ->
        notify_parent({:saved, patron})

        {:noreply,
         socket
         |> put_flash(:info, "Patron created successfully")
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
