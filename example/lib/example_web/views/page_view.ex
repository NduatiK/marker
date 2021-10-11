defmodule ExampleWeb.PageView do
  use ExampleWeb, :view
  use Marker
  require Marker.HTML
  import Element
  alias Element.Input, as: Input

  template :index do
    [
      # div class: "jumbotron" do
      #   h2 gettext("Welcome to %{name}", name: "Phoenix!")

      #   p [
      #       "A productive web framework that",
      #       br,
      #       "does not compromise speed and maintainability."
      #     ],
      #     class: "lead"
      # end,
      Input.text(
        id: "above",
        attrs: [id: "aj"],
        label: Input.label_above("Above")
      )
      # Input.text(
      #   id: "below",
      #   attrs: [],
      #   label: Input.label_below("Below")
      # ),
      # Input.text(
      #   id: "left",
      #   attrs: [],
      #   label: Input.label_left("Left")
      # ),
      # Input.text(
      #   id: "right",
      #   attrs: [],
      #   label: Input.label_right("Right")
      # ),
      # row do
      #   column do
      #     h4 "Resources"

      #     column do
      #       a "Guides", href: "http://phoenixframework.org/docs/overview"
      #       a "Docs", href: "https://hexdocs.pm/phoenix"
      #       a "Source", href: "https://github.com/phoenixframework/phoenix"
      #     end
      #   end

      #   column do
      #     h4 "Help"

      #     column do
      #       a "Mailing list", href: "http://groups.google.com/group/phoenix-talk"

      #       a "#elixir-lang on freenode IRC",
      #         href: "http://webchat.freenode.net/?channels=elixir-lang"

      #       a "@elixirphoenix", href: "https://twitter.com/elixirphoenix"
      #     end
      #   end
      # end
    ]
  end

  def render("index.html", assigns), do: index(assigns)
end
