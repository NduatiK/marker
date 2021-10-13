defmodule Element.Input do
  use Marker
  require Marker.HTML
  import Element

  Marker.template :button do
    on_click = @onPress
    label = @__content__

    button [] do
      label
    end

    # button :
    #   List (Attribute msg)
    #   -> { onPress : Maybe msg
    #      , label : Element msg
    #      }
    #   -> Element msg
  end

  for position <- ~w[left right above below]a do
    def unquote(String.to_atom("label_" <> Atom.to_string(position)))(content) do
      {
        :label,
        unquote(position),
        Marker.HTML.label class: "flex text-sm font-medium text-gray-700" do
          content
        end
      }
    end
  end

  Marker.template :text do
    {:label, position, input_label} = @label

    input_attr =
      Keyword.merge(@attrs,
        type: "text",
        class:
          "focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-3 pr-3 sm:text-sm border-gray-300 rounded-md"
      )

    input_ =
      div([class: "flex"], [
        input(input_attr)
      ])

    case position do
      :above ->
        column class: Element.spacing_y(1) <> "mt-1 w-full max-w-xs" do
          input_label
          input_
        end

      :below ->
        column class: Element.spacing_y(1) <> "mt-1 w-full max-w-xs" do
          input_
          input_label
        end

      :left ->
        row class: Element.spacing_x(4) <> "mt-1 w-full max-w-xs" do
          input_label
          input_
        end

      :right ->
        row class: Element.spacing_x(2) <> "mt-1 w-full max-w-xs" do
          input_
          input_label
        end
    end
  end
end
