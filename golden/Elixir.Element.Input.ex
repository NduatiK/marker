defmodule Element.Input do
  def text(assigns) do
    (
      Marker.HTML

      (
        Kernel
        Marker.HTML
      )
    )

    _ = assigns

    :erlang.element(
      1,
      Code.eval_quoted(
        (
          {:label, position, input_label} = Marker.fetch_assign!(assigns, :label)

          input_attr =
            Keyword.merge(Marker.fetch_assign!(assigns, :attrs),
              type: "text",
              class:
                "focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-3 pr-3 sm:text-sm border-gray-300 rounded-md"
            )

          input_ =
            {:safe,
             Marker.Compiler.concat(
               :lists.reverse([
                 "</div>"
                 | (
                     expr =
                       Marker.Encoder.encode(
                         Marker.Compiler.concat(
                           :lists.reverse([
                             "/>"
                             | Enum.reduce(input_attr, ["<input" | []], fn
                                 {_, nil}, chunks ->
                                   chunks

                                 {_, false}, chunks ->
                                   chunks

                                 {k, true}, chunks ->
                                   Marker.Compiler.enabled_attr(chunks, k)

                                 {k, v}, chunks ->
                                   Marker.Compiler.attr(chunks, k, v)
                               end)
                           ])
                         )
                       )

                     [expr | [">" | [" class='flex'" | ["<div" | []]]]]
                   )
               ])
             )}

          case(position) do
            :above ->
              Element.column__template(%{
                __content__: List.wrap([input_label, input_]),
                class: <<" space-y-1 "::binary(), "mt-1 w-full max-w-xs mx-auto">>
              })

            :below ->
              Element.column__template(%{
                __content__: List.wrap([input_, input_label]),
                class: <<" space-y-1 "::binary(), "mt-1 w-full max-w-xs mx-auto">>
              })

            :left ->
              Element.row__template(%{
                __content__: List.wrap([input_label, input_]),
                class: <<" space-x-4 "::binary(), "mt-1 w-full max-w-xs mx-auto">>
              })

            :right ->
              Element.row__template(%{
                __content__: List.wrap([input_, input_label]),
                class: <<" space-x-2 "::binary(), "mt-1 w-full max-w-xs mx-auto">>
              })
          end
        ),
        []
      )
    )
  end

  def label_right(content) do
    {:label, :right,
     {:safe,
      Marker.Compiler.concat(
        :lists.reverse([
          "</label>"
          | (
              expr = Marker.Encoder.encode(content)

              [
                expr
                | [">" | [" class='flex  text-sm font-medium text-gray-700'" | ["<label" | []]]]
              ]
            )
        ])
      )}}
  end

  def label_left(content) do
    {:label, :left,
     {:safe,
      Marker.Compiler.concat(
        :lists.reverse([
          "</label>"
          | (
              expr = Marker.Encoder.encode(content)

              [
                expr
                | [">" | [" class='flex  text-sm font-medium text-gray-700'" | ["<label" | []]]]
              ]
            )
        ])
      )}}
  end

  def label_below(content) do
    {:label, :below,
     {:safe,
      Marker.Compiler.concat(
        :lists.reverse([
          "</label>"
          | (
              expr = Marker.Encoder.encode(content)

              [
                expr
                | [">" | [" class='flex  text-sm font-medium text-gray-700'" | ["<label" | []]]]
              ]
            )
        ])
      )}}
  end

  def label_above(content) do
    {:label, :above,
     {:safe,
      Marker.Compiler.concat(
        :lists.reverse([
          "</label>"
          | (
              expr = Marker.Encoder.encode(content)

              [
                expr
                | [">" | [" class='flex  text-sm font-medium text-gray-700'" | ["<label" | []]]]
              ]
            )
        ])
      )}}
  end

  def a() do
    " space-x-3 space-y-3 "
  end
end