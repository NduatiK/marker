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
             Enum.reduce(
               :erlang.++(
                 (
                   expr =
                     Marker.Encoder.encode(
                       Enum.reduce(
                         :erlang.++(
                           Enum.reduce(input_attr, :erlang.++([], ["<input"]), fn
                             {_, nil}, chunks ->
                               chunks

                             {_, false}, chunks ->
                               chunks

                             {k, true}, chunks ->
                               Marker.Compiler.enabled_attr(chunks, k)

                             {k, v}, chunks ->
                               Marker.Compiler.attr(chunks, k, v)
                           end),
                           ["/>"]
                         ),
                         fn chunk, acc -> <<acc::binary(), chunk::binary()>> end
                       )
                     )

                   :erlang.++(
                     :erlang.++(:erlang.++(:erlang.++([], ["<div"]), [" class='flex'"]), [">"]),
                     [expr]
                   )
                 ),
                 ["</div>"]
               ),
               fn chunk, acc -> <<acc::binary(), chunk::binary()>> end
             )}

          case(position) do
            :above ->
              Element.column__template(%{
                __content__: List.wrap([input_label, input_]),
                class: <<" space-y-1 "::binary(), "mt-1 w-full max-w-xs">>
              })

            :below ->
              Element.column__template(%{
                __content__: List.wrap([input_, input_label]),
                class: <<" space-y-1 "::binary(), "mt-1 w-full max-w-xs">>
              })

            :left ->
              Element.row__template(%{
                __content__: List.wrap([input_label, input_]),
                class: <<" space-x-4 "::binary(), "mt-1 w-full max-w-xs">>
              })

            :right ->
              Element.row__template(%{
                __content__: List.wrap([input_, input_label]),
                class: <<" space-x-2 "::binary(), "mt-1 w-full max-w-xs">>
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
      Enum.reduce(
        :erlang.++(
          (
            expr = Marker.Encoder.encode(content)

            :erlang.++(
              :erlang.++(
                :erlang.++(:erlang.++([], ["<label"]), [
                  " class='flex  text-sm font-medium text-gray-700'"
                ]),
                [">"]
              ),
              [expr]
            )
          ),
          ["</label>"]
        ),
        fn chunk, acc -> <<acc::binary(), chunk::binary()>> end
      )}}
  end

  def label_left(content) do
    {:label, :left,
     {:safe,
      Enum.reduce(
        :erlang.++(
          (
            expr = Marker.Encoder.encode(content)

            :erlang.++(
              :erlang.++(
                :erlang.++(:erlang.++([], ["<label"]), [
                  " class='flex  text-sm font-medium text-gray-700'"
                ]),
                [">"]
              ),
              [expr]
            )
          ),
          ["</label>"]
        ),
        fn chunk, acc -> <<acc::binary(), chunk::binary()>> end
      )}}
  end

  def label_below(content) do
    {:label, :below,
     {:safe,
      Enum.reduce(
        :erlang.++(
          (
            expr = Marker.Encoder.encode(content)

            :erlang.++(
              :erlang.++(
                :erlang.++(:erlang.++([], ["<label"]), [
                  " class='flex  text-sm font-medium text-gray-700'"
                ]),
                [">"]
              ),
              [expr]
            )
          ),
          ["</label>"]
        ),
        fn chunk, acc -> <<acc::binary(), chunk::binary()>> end
      )}}
  end

  def label_above(content) do
    {:label, :above,
     {:safe,
      Enum.reduce(
        :erlang.++(
          (
            expr = Marker.Encoder.encode(content)

            :erlang.++(
              :erlang.++(
                :erlang.++(:erlang.++([], ["<label"]), [
                  " class='flex  text-sm font-medium text-gray-700'"
                ]),
                [">"]
              ),
              [expr]
            )
          ),
          ["</label>"]
        ),
        fn chunk, acc -> <<acc::binary(), chunk::binary()>> end
      )}}
  end

  def button(assigns) do
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
          on_click = Marker.fetch_assign!(assigns, :onPress)
          label = Marker.fetch_assign!(assigns, :__content__)

          {:safe,
           Enum.reduce(
             :erlang.++(
               (
                 expr = Marker.Encoder.encode(label)
                 :erlang.++(:erlang.++(:erlang.++([], ["<button"]), [">"]), [expr])
               ),
               ["</button>"]
             ),
             fn chunk, acc -> <<acc::binary(), chunk::binary()>> end
           )}
        ),
        []
      )
    )
  end

  def a() do
    " space-x-3 space-y-3 "
  end
end