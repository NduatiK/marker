defmodule Element.Input do
  use Marker
  require Marker.HTML
  import Element

  for position <- ~w[left right above below]a do
    def unquote(String.to_atom("label_" <> Atom.to_string(position)))(content) do
      {:label, unquote(position), Marker.HTML.label(content)}
    end
  end

  Marker.template :text do
    {:label, position, input_label} = @label

    IO.inspect(@attrs)

    input_ =
      div @attrs do
        # div(Keyword.merge(@attrs, id: @id, class: "s e ctr ccy acr")) do
        # input(id: @id, class: "s e ctr ccy acr") do
        span @id
      end

    case position do
      :above ->
        column do
          input_label
          input_
        end

      :below ->
        column do
          input_
          input_label
        end

      :left ->
        row do
          input_label
          input_
        end

      :right ->
        row do
          input_
          input_label
        end
    end
  end
end
