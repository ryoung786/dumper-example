defmodule LibraryWeb.PatronLive.Show do
  use LibraryWeb, :live_view

  alias Library.Patrons

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:patron, Patrons.get_patron!(id))}
  end

  defp page_title(:show), do: "Show Patron"
  defp page_title(:edit), do: "Edit Patron"
end
