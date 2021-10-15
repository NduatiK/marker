defmodule GoldenWeb.UserLive.FormComponent2 do
  def update(%{user: user} = assigns, socket) do
    changeset = Accounts.change_user(user)

    {:ok,
     Phoenix.LiveView.assign(Phoenix.LiveView.assign(socket, assigns), :changeset, changeset)}
  end

  def render(assigns) do
    Phoenix.LiveView.Helpers

    (
      Phoenix.LiveView.Engine

      (
        dynamic = fn track_changes? ->
          changed =
            case(assigns) do
              %{__changed__: changed} when track_changes? ->
                changed

              _ ->
                nil
            end

          arg0 =
            case(Phoenix.LiveView.Engine.changed_assign?(changed, :counter)) do
              true ->
                Phoenix.LiveView.Engine.live_to_iodata(
                  ElmView.Helpers.escape(Phoenix.LiveView.Engine.fetch_assign!(assigns, :counter))
                )

              false ->
                nil
            end

          [arg0]
        end

        %Phoenix.LiveView.Rendered{
          static: [
            "<div class='flex flex-col px-4' class='py-4'><h4>It starts now!</h4><div class='flex items-center space-x-8' class='space-y-8'><button class='bg-blue-50 hover:bg-blue-100 text-blue-700 font-semibold py-2 px-4 rounded' phx-click='decrement'><span>&lt;-</span></button> <span>",
            "</span><button class='bg-blue-50 hover:bg-blue-100 text-blue-700 font-semibold py-2 px-4 rounded' phx-click='increment'><span>-&gt;</span></button> </div></div>"
          ],
          dynamic: dynamic,
          fingerprint: 337_195_539_286_398_956_153_318_888_688_829_727_859,
          root: true
        }
      )
    )
  end

  def mount(_params, _session, socket) do
    GoldenWeb.Endpoint.subscribe("form")
    {:ok, Phoenix.LiveView.assign(socket, :counter, 0)}
  end

  def handle_info(%{topic: "form", payload: counter}, socket) do
    {:noreply, Phoenix.LiveView.assign(socket, :counter, counter)}
  end

  def handle_event("increment", _, socket) do
    counter =
      (fn
         num when :erlang.is_integer(num) ->
           :erlang.+(num, 1)

         _ ->
           1
       end).(socket.assigns.counter)

    GoldenWeb.Endpoint.broadcast_from(:erlang.self(), "form", "update_event", counter)
    {:noreply, Phoenix.LiveView.assign(socket, :counter, counter)}
  end

  def handle_event("decrement", _, socket) do
    counter =
      (fn
         num when :erlang.is_integer(num) ->
           :erlang.-(num, 1)

         _ ->
           0
       end).(socket.assigns.counter)

    GoldenWeb.Endpoint.broadcast_from(:erlang.self(), "form", "update_event", counter)
    {:noreply, Phoenix.LiveView.assign(socket, :counter, counter)}
  end

  def __live__() do
    %{
      container: {:div, []},
      kind: :view,
      layout: {GoldenWeb.LayoutView, "live.html"},
      lifecycle: %{
        __struct__: Phoenix.LiveView.Lifecycle,
        handle_event: [],
        handle_info: [],
        handle_params: [],
        mount: []
      },
      module: GoldenWeb.UserLive.FormComponent2,
      name: "UserLive.FormComponent2"
    }
  end
end