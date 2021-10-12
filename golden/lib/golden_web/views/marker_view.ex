defmodule GoldenWeb.MarkerView do
  use GoldenWeb, :view
  use Marker
  require Marker.HTML
  import Element
  alias Element.Input, as: Input

  template :index do
    greeting = gettext("Welcome to %{name}", name: "Phoenix!")

    [
      div class: "jumbotron" do
        h2([class: "h2"], [
          greeting
        ])

        # p(
        #   class: "lead",
        #   [
        #     "A productive web framework that",
        #     br,
        #     "does not compromise speed and maintainability."
        #   ]
        # )
      end,
      # div class: "customer" do
      #   div [] do
      #     span("name: ")
      #     span("name")
      #   end

      #   div [] do
      #     span("email: ")
      #     span("email")
      #   end

      #   div [] do
      #     span("phone: ")
      #     span("phone")
      #   end
      # end,
      div style: "padding: 10px" do
        div do
          column spacing: 4 do
            Input.text(
              id: "above",
              attrs: [id: "aj"],
              label: Input.label_above("Above")
            )

            # input(
            #   class:
            #     "w-full px-3 py-2 text-sm leading-tight text-gray-700 border rounded shadow appearance-none focus:outline-none focus:shadow-outline",
            #   id: "firstName",
            #   type: "text",
            #   placeholder: "First Name"
            # )

            Input.text(
              id: "below",
              attrs: [],
              label: Input.label_below("Below")
            )

            Input.text(
              id: "left",
              attrs: [],
              label: Input.label_left("Left")
            )

            Input.text(
              id: "right",
              attrs: [],
              label: Input.label_right("Right")
            )

            # row do
            #   column do
            #     h4("Resources")

            #     column do
            #       a("Guides", href: "http://phoenixframework.org/docs/overview")
            #       a("Docs", href: "https://hexdocs.pm/phoenix")
            #       a("Source", href: "https://github.com/phoenixframework/phoenix")
            #     end
            #   end

            #   column do
            #     h4("Help")

            #     column do
            #       a("Mailing list", href: "http://groups.google.com/group/phoenix-talk")

            #       a("#elixir-lang on freenode IRC",
            #         href: "http://webchat.freenode.net/?channels=elixir-lang"
            #       )

            #       a("@elixirphoenix", href: "https://twitter.com/elixirphoenix")
            #     end
            #   end
            # end
          end
        end
      end
    ]
  end

  def render("index.html", assigns), do: index(assigns)
end
