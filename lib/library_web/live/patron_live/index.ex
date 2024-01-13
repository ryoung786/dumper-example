defmodule LibraryWeb.PatronLive.Index do
  use LibraryWeb, :live_view

  alias Library.Patrons
  alias Library.Patrons.Patron

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :patrons, Patrons.list_patrons())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Patron")
    |> assign(:patron, Patrons.get_patron!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Patron")
    |> assign(:patron, %Patron{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Patrons")
    |> assign(:patron, nil)
  end

  @impl true
  def handle_info({LibraryWeb.PatronLive.FormComponent, {:saved, patron}}, socket) do
    {:noreply, stream_insert(socket, :patrons, patron)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    patron = Patrons.get_patron!(id)
    {:ok, _} = Patrons.delete_patron(patron)

    {:noreply, stream_delete(socket, :patrons, patron)}
  end
end
