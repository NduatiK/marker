defmodule GoldenWeb.UserLive.Table do
  use GoldenWeb, :live_component

  import ElmView
  alias ElmView.Input
  require ElmView
  alias Golden.Accounts.User

  @dom column(
         [
           padding: 4,
           spacing: 4
           #  above:
           #    el(
           #      [
           #        class: "bg-white shadow rounded-md ",
           #        padding_x: 2,
           #        padding_y: 2
           #      ],
           #      text("YYY")
           #    )
         ],
         [
           text(:h4, "It starts now!"),
           table([],
             data: {:users, &__MODULE__.identity/1},
             columns: [
               tableColumn(
                 "Name",
                 row([spacing: 4], [
                   image(
                     [class: "h-10 w-10 rounded-full"],
                     :image
                   ),
                   column([], [
                     el([class: ""], text(:name)),
                     el([class: "text-sm text-gray-500"], text(:email))
                   ])
                 ])
               ),
               tableColumn("Email", text(:email)),
               tableColumn("Status", text("Status")),
               tableColumn("Role", text("Role")),
               tableColumn(
                 "",
                 row([spacing: 2], [
                   ElmView.live_redirect(
                     [],
                     "Show",
                     "{Routes.user_show_path(@socket, :show, row.id)}"
                   ),
                   ElmView.live_patch(
                     [],
                     "Edit",
                     "{Routes.user_index_path(@socket, :edit, row.id)}"
                   )
                   #  ElmView.raw("""
                   #  <span><%= live_redirect "Show", to: Routes.user_show_path(@socket, :show, row) %></span>
                   #  """),
                   #  ElmView.raw("""
                   #  <span><%= live_patch "Edit", to: Routes.user_index_path(@socket, :edit, row) %></span>
                   #  """),
                   #  ElmView.raw("""
                   #  <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: row.id, data: [confirm: "Are you sure?"] %></span>
                   #  """)

                   #  ElmView.link([], "Edit", "{Routes.user_show_path(@socket, :show, row)}"),
                   #  ElmView.link([], "Show", "#"),
                   #  ElmView.link([class: "text-red"], "Delete", "#")
                 ])
               )
             ]
           )
         ]
       )
       |> ElmView.render()

  def identity(a) do
    a
  end

  @impl true
  def render(assigns) do
    compile(@dom)
  end
end
