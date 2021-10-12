defmodule Element.Input do
  use Marker
  require Marker.HTML
  import Element

  for position <- ~w[left right above below]a do
    def unquote(String.to_atom("label_" <> Atom.to_string(position)))(content) do
      {
        :label,
        unquote(position),
        Marker.HTML.label class: "flex  text-sm font-medium text-gray-700" do
          content
        end
        # for: ,
      }
    end
  end

  @space Element.spacing(3)
  def a, do: Element.spacing(3)

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
        column class: Element.spacing_y(1) <> "mt-1 w-full max-w-xs mx-auto" do
          input_label
          input_
        end

      :below ->
        column class: Element.spacing_y(1) <> "mt-1 w-full max-w-xs mx-auto" do
          input_
          input_label
        end

      :left ->
        row class: Element.spacing_x(4) <> "mt-1 w-full max-w-xs mx-auto" do
          input_label
          input_
        end

      :right ->
        row class: Element.spacing_x(2) <> "mt-1 w-full max-w-xs mx-auto" do
          input_
          input_label
        end
    end
  end
end
