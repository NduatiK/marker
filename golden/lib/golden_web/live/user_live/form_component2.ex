defmodule GoldenWeb.UserLive.FormComponent2 do
  use GoldenWeb, :live_view

  import ElmView
  alias ElmView.Input
  require ElmView

  #  column([id: "project-info-{@id}"], [
  @dom ElmView.render(
         column([padding: 4], [
           text(:h4, "It starts now!"),
           row([spacing: 8], [
             Input.button([],
               on_press: :decrement,
               label: text("<-")
             ),
             text(:counter),
             Input.button([],
               on_press: :increment,
               label: text("->")
             )
           ])
         ])
       )

  @impl true
  def render(assigns) do
    compile(@dom)
  end

  @topic "form"

  @impl true
  def mount(_params, _session, socket) do
    GoldenWeb.Endpoint.subscribe(@topic)

    {:ok, assign(socket, :counter, 0)}
  end

  @impl true
  def update(%{user: user} = assigns, socket) do
    changeset = Accounts.change_user(user)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("increment", _, socket) do
    counter =
      socket.assigns.counter
      |> then(fn
        num when is_integer(num) -> num + 1
        _ -> 1
      end)

    GoldenWeb.Endpoint.broadcast_from(self(), @topic, "update_event", counter)

    {:noreply, assign(socket, :counter, counter)}
  end

  @impl true
  def handle_event("decrement", _, socket) do
    counter =
      socket.assigns.counter
      |> then(fn
        num when is_integer(num) -> num - 1
        _ -> 0
      end)

    GoldenWeb.Endpoint.broadcast_from(self(), @topic, "update_event", counter)

    {:noreply, assign(socket, :counter, counter)}
  end

  def handle_info(%{topic: @topic, payload: counter}, socket) do
    {:noreply, assign(socket, :counter, counter)}
  end
end
