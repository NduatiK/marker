defmodule GoldenWeb.UserLive.FormComponent2 do
  use GoldenWeb, :live_view

  import ElmView
  alias ElmView.Input
  require ElmView
  alias Golden.Accounts.User

  @dom column([padding: 4, spacing: 4], [
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
         ]),
         table(
           [],
           data: {:table_data, &__MODULE__.identity/1},
           columns: [
             tableColumn("Name"),
             tableColumn("Email"),
             tableColumn("Status"),
             tableColumn("Role"),
             tableColumn("")
           ]
         )
       ])
       |> ElmView.render()

  def identity(a) do
    a
  end

  @impl true
  def render(assigns) do
    compile(@dom)
  end

  @topic "form"

  @impl true
  def mount(_params, _session, socket) do
    GoldenWeb.Endpoint.subscribe(@topic)

    {:ok,
     socket
     |> assign(:counter, 0)
     |> assign(:table_data, [
       %User{name: "Jane Cooper", email: "jane.cooper@example.com", age: 20},
       %User{name: "Cody Fisher", email: "cody.fisher@example.com", age: 20},
       %User{name: "Esther Howard", email: "esther.howard@example.com", age: 20},
       %User{name: "Jenny Wilson", email: "jenny.wilson@example.com", age: 20},
       %User{name: "Kristin Watson", email: "kristin.watson@example.com", age: 20}
     ])}
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

  @impl true
  def handle_info(%{topic: @topic, payload: counter}, socket) do
    {:noreply, assign(socket, :counter, counter)}
  end
end
