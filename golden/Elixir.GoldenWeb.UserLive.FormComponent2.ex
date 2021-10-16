defmodule GoldenWeb.UserLive.FormComponent2 do
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

          (
            arg0 =
              case(Phoenix.LiveView.Engine.changed_assign?(changed, :counter)) do
                true ->
                  Phoenix.LiveView.Engine.live_to_iodata(
                    ElmView.Helpers.escape(
                      Phoenix.LiveView.Engine.fetch_assign!(assigns, :counter)
                    )
                  )

                false ->
                  nil
              end

            arg1 =
              case(Phoenix.LiveView.Engine.changed_assign?(changed, :table_data)) do
                true ->
                  %Phoenix.LiveView.Comprehension{
                    static: [
                      "\n        <tr>\n        <td class=\"px-6 py-4 whitespace-nowrap\">\n  <div class='flex items-center space-x-4'><div class=\"flex-shrink-0 h-10 w-10\">\n  <img",
                      " alt='' class=' h-10 w-10 rounded-full'>\n</div>\n<div class='flex flex-col'><div class=''><span>",
                      "</span></div><div class='text-sm text-gray-500'><span>",
                      "</span></div></div></div>\n</td>\n<td class=\"px-6 py-4 whitespace-nowrap\">\n  <span>",
                      "</span>\n</td>\n<td class=\"px-6 py-4 whitespace-nowrap\">\n  <span>Status</span>\n</td>\n<td class=\"px-6 py-4 whitespace-nowrap\">\n  <span>Role</span>\n</td>\n<td class=\"px-6 py-4 whitespace-nowrap\">\n  <a class='text-indigo-600 hover:text-indigo-900' href='#'>Edit</a>\n</td>\n\n        </tr>\n      "
                    ],
                    dynamics:
                      for(
                        {row, index} <-
                          Enum.with_index(
                            (&GoldenWeb.UserLive.FormComponent2.identity/1).(
                              Phoenix.LiveView.Engine.fetch_assign!(assigns, :table_data)
                            )
                          )
                      ) do
                        arg1 =
                          :erlang.element(
                            2,
                            Phoenix.HTML.Tag.attributes_escape([
                              {{:safe, "src"}, ElmView.Helpers.escape(row.image)}
                            ])
                          )

                        arg2 =
                          Phoenix.LiveView.Engine.live_to_iodata(ElmView.Helpers.escape(row.name))

                        arg3 =
                          Phoenix.LiveView.Engine.live_to_iodata(
                            ElmView.Helpers.escape(row.email)
                          )

                        arg4 =
                          Phoenix.LiveView.Engine.live_to_iodata(
                            ElmView.Helpers.escape(row.email)
                          )

                        [arg1, arg2, arg3, arg4]
                      end,
                    fingerprint: 63_640_606_279_608_319_076_411_251_247_704_334_107
                  }

                false ->
                  nil
              end
          )

          [arg0, arg1]
        end

        %Phoenix.LiveView.Rendered{
          static: [
            "<div class='flex flex-col px-4 py-4 space-y-4'><h4>It starts now!</h4><div class='flex items-center space-x-8'><button class='bg-blue-50 hover:bg-blue-100 text-blue-700 font-semibold py-2 px-4 rounded' phx-click='decrement'><span>&lt;-</span></button> <span>",
            "</span><button class='bg-blue-50 hover:bg-blue-100 text-blue-700 font-semibold py-2 px-4 rounded' phx-click='increment'><span>-&gt;</span></button> </div><div class=\"align-middle inline-block min-w-full shadow overflow-x-auto sm:rounded-lg border-b border-gray-200\">\n  <table class=\"w-full divide-y divide-gray-200  border-b border-gray-200 shadow sm:rounded-lg\">\n    <thead class=\"bg-gray-50\">\n      <tr><th scope='col' class='px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider'>Name</th><th scope='col' class='px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider'>Email</th><th scope='col' class='px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider'>Status</th><th scope='col' class='px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider'>Role</th><th scope='col' class='px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider'></th></tr>\n    </thead>\n    <tbody class=\"bg-white divide-y divide-gray-200\">\n\n      ",
            "\n    </tbody>\n  </table>\n</div>\n</div>"
          ],
          dynamic: dynamic,
          fingerprint: 54_066_104_352_584_220_778_371_197_868_385_930_082,
          root: true
        }
      )
    )
  end

  def mount(_params, _session, socket) do
    GoldenWeb.Endpoint.subscribe("form")

    {:ok,
     Phoenix.LiveView.assign(Phoenix.LiveView.assign(socket, :counter, 0), :table_data, [
       %Golden.Accounts.User{
         __meta__: %{
           __struct__: Ecto.Schema.Metadata,
           context: nil,
           prefix: nil,
           schema: Golden.Accounts.User,
           source: "users",
           state: :built
         },
         id: nil,
         inserted_at: nil,
         updated_at: nil,
         name: "Jane Cooper",
         email: "jane.cooper@example.com",
         image:
           "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=4&w=256&h=256&q=60",
         age: 20
       },
       %Golden.Accounts.User{
         __meta__: %{
           __struct__: Ecto.Schema.Metadata,
           context: nil,
           prefix: nil,
           schema: Golden.Accounts.User,
           source: "users",
           state: :built
         },
         id: nil,
         inserted_at: nil,
         updated_at: nil,
         name: "Cody Fisher",
         email: "cody.fisher@example.com",
         image:
           "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=4&w=256&h=256&q=60",
         age: 20
       },
       %Golden.Accounts.User{
         __meta__: %{
           __struct__: Ecto.Schema.Metadata,
           context: nil,
           prefix: nil,
           schema: Golden.Accounts.User,
           source: "users",
           state: :built
         },
         id: nil,
         inserted_at: nil,
         updated_at: nil,
         name: "Esther Howard",
         email: "esther.howard@example.com",
         image:
           "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=4&w=256&h=256&q=60",
         age: 20
       },
       %Golden.Accounts.User{
         __meta__: %{
           __struct__: Ecto.Schema.Metadata,
           context: nil,
           prefix: nil,
           schema: Golden.Accounts.User,
           source: "users",
           state: :built
         },
         id: nil,
         inserted_at: nil,
         updated_at: nil,
         name: "Jenny Wilson",
         email: "jenny.wilson@example.com",
         image:
           "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=4&w=256&h=256&q=60",
         age: 20
       },
       %Golden.Accounts.User{
         __meta__: %{
           __struct__: Ecto.Schema.Metadata,
           context: nil,
           prefix: nil,
           schema: Golden.Accounts.User,
           source: "users",
           state: :built
         },
         id: nil,
         inserted_at: nil,
         updated_at: nil,
         name: "Kristin Watson",
         email: "kristin.watson@example.com",
         image:
           "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=4&w=256&h=256&q=60",
         age: 20
       }
     ])}
  end

  def identity(a) do
    a
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