defmodule PentoWeb.SearchLive do
  use PentoWeb, :live_view

  alias Pento.Catalog
  alias Pento.Catalog.Product

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_products()
     |> assign_changeset()}
  end

  def assign_products(socket) do
    # Catalog.list_products())
    stream(socket, :products, [])
  end

  def assign_changeset(socket) do
    assign(socket, :changeset, to_form(Catalog.search_by_sku(%Product{})))
  end

  def handle_event("validate", %{"product" => sku_params}, socket) do
    changeset =
      %Product{}
      |> Catalog.search_by_sku(sku_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, to_form(changeset))}
  end

  def handle_event("search", %{"product" => sku_params}, socket) do
    changeset =
      %Product{}
      |> Catalog.search_by_sku(sku_params)
      |> Map.put(:action, :search)

    if changeset.valid? do
      product = Catalog.find_product_by_sku(changeset.changes.sku)

      {:noreply,
       socket
       |> stream_insert(:products, product, at: -1)}
    else
      {:noreply, assign(socket, :changeset, to_form(changeset))}
    end
  end
end
