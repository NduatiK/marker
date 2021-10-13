defmodule GoldenWeb.MarkerView do
  use GoldenWeb, :view
  # use Marker
  # require Marker.HTML
  # import Element
  # alias Element.Input, as: Input

  # template :index do
  #   greeting = gettext("Welcome to %{name}", name: "Phoenix!")

  #   div(
  #     [class: "p-4", style: "background: #fafafa"],
  #     [
  #       h2([class: "h2"], greeting),
  #       h2([class: "h2"], @conn.host),
  #       # p(
  #       #   class: "lead",
  #       #   [
  #       #     "A productive web framework that",
  #       #     br,
  #       #     "does not compromise speed and maintainability."
  #       #   ]
  #       # )
  #       # div class: "customer" do
  #       #   div [] do
  #       #     span("name: ")
  #       #     span("name")
  #       #   end

  #       #   div [] do
  #       #     span("email: ")
  #       #     span("email")
  #       #   end

  #       #   div [] do
  #       #     span("phone: ")
  #       #     span("phone")
  #       #   end
  #       # end,
  #       div style: "padding: 10px" do
  #         div do
  #           column spacing: 4, id: "av", class: "mango" do
  #             Input.text(
  #               id: "above",
  #               attrs: [id: "aj_brown  "],
  #               label: Input.label_above("Above")
  #             )

  #             # input(
  #             #   class:
  #             #     "w-full px-3 py-2 text-sm leading-tight text-gray-700 border rounded shadow appearance-none focus:outline-none focus:shadow-outline",
  #             #   id: "firstName",
  #             #   type: "text",
  #             #   placeholder: "First Name"
  #             # )

  #             Input.text(
  #               id: "below",
  #               attrs: [],
  #               label: Input.label_below("Below")
  #             )

  #             Input.text(
  #               id: "left",
  #               attrs: [],
  #               label: Input.label_left("Left")
  #             )

  #             Input.text(
  #               id: "right",
  #               attrs: [],
  #               label: Input.label_right("Right")
  #             )

  #             # row do
  #             #   column do
  #             #     h4("Resources")

  #             #     column do
  #             #       a("Guides", href: "http://phoenixframework.org/docs/overview")
  #             #       a("Docs", href: "https://hexdocs.pm/phoenix")
  #             #       a("Source", href: "https://github.com/phoenixframework/phoenix")
  #             #     end
  #             #   end

  #             #   column do
  #             #     h4("Help")

  #             #     column do
  #             #       a("Mailing list", href: "http://groups.google.com/group/phoenix-talk")

  #             #       a("#elixir-lang on freenode IRC",
  #             #         href: "http://webchat.freenode.net/?channels=elixir-lang"
  #             #       )

  #             #       a("@elixirphoenix", href: "https://twitter.com/elixirphoenix")
  #             #     end
  #             #   end
  #             # end
  #           end
  #         end
  #       end
  #     ]
  #   )
  # end

  # defmacro index2(assigns) do
  #   use Marker
  #   import Marker.HTML

  #   quote do
  #     greeting = gettext("Welcome to %{name}", name: "Phoenix!")

  #     {:safe, var!(html)} =
  #       Marker.HTML.div(
  #         [class: "p-4", style: "background: #fafafa"],
  #         [
  #           Marker.HTML.h2([class: "h2"], greeting),
  #           h2([class: "h2"], unquote(assigns).conn.host)
  #           # div style: "padding: 10px" do
  #           #   div do
  #           #     column spacing: 4, id: "av", class: "mango" do
  #           #       Input.text(
  #           #         id: "above",
  #           #         attrs: [id: "aj"],
  #           #         label: Input.label_above("Above")
  #           #       )

  #           #       # input(
  #           #       #   class:
  #           #       #     "w-full px-3 py-2 text-sm leading-tight text-gray-700 border rounded shadow appearance-none focus:outline-none focus:shadow-outline",
  #           #       #   id: "firstName",
  #           #       #   type: "text",
  #           #       #   placeholder: "First Name"
  #           #       # )

  #           #       Input.text(
  #           #         id: "below",
  #           #         attrs: [],
  #           #         label: Input.label_below("Below")
  #           #       )

  #           #       Input.text(
  #           #         id: "left",
  #           #         attrs: [],
  #           #         label: Input.label_left("Left")
  #           #       )

  #           #       Input.text(
  #           #         id: "right",
  #           #         attrs: [],
  #           #         label: Input.label_right("Right")
  #           #       )
  #           #     end
  #           #   end
  #           # end
  #         ]
  #       )

  #     Marker.Compiler.expand(var!(html), __ENV__)
  #   end
  # end

  # def index3(assigns) do
  #   quote do: unquote(index2(%{conn: %{host: "asd"}}))
  # end

  import ElmView
  require ElmView

  def index(assigns) do
    column([], [
      h2(:title),
      text("Hello"),
      text("Hello" <> " There")
    ])
    |> compile()
  end

  # def render("index.html", assigns), do: index(IO.inspect(assigns)) |> IO.inspect()
  def render("index.html", assigns), do: index(%{title: "Let's go"}) |> IO.inspect()
end
