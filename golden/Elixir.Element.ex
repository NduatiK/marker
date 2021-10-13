defmodule Element do
  defmacro spacing_y(space) do
    <<" space-y-", String.Chars.to_string(space)::binary(), " ">>
  end

  defmacro spacing_xy(x, y) do
    <<" space-x-", String.Chars.to_string(x)::binary(), " space-y-",
      String.Chars.to_string(y)::binary(), " ">>
  end

  defmacro spacing_x(space) do
    <<" space-x-", String.Chars.to_string(space)::binary(), " ">>
  end

  defmacro spacing(space) do
    <<" space-x-", String.Chars.to_string(space)::binary(), " space-y-",
      String.Chars.to_string(space)::binary(), " ">>
  end

  def shrink() do
    "flex-initial"
  end

  def row__template(assigns) do
    (
      Marker.HTML

      (
        Kernel
        Marker.HTML
      )
    )

    _ = assigns

    (
      attrs = [
        class:
          <<case(Map.get(assigns, :class)) do
              x when :erlang.orelse(:erlang."=:="(x, false), :erlang."=:="(x, nil)) ->
                ""

              x ->
                x
            end::binary(), " flex flex-row items-center">>
      ]

      {:safe,
       Marker.Compiler.concat(
         :lists.reverse([
           "</div>"
           | (
               expr = Marker.Encoder.encode(Map.get(assigns, :__content__))

               [
                 expr
                 | [
                     ">"
                     | Enum.reduce(attrs, ["<div" | []], fn
                         {_, nil}, chunks ->
                           chunks

                         {_, false}, chunks ->
                           chunks

                         {k, true}, chunks ->
                           Marker.Compiler.enabled_attr(chunks, k)

                         {k, v}, chunks ->
                           Marker.Compiler.attr(chunks, k, v)
                       end)
                   ]
               ]
             )
         ])
       )}
    )
  end

  defmacro row(content_or_attrs, maybe_content) do
    {attrs, content} = Marker.Element.normalize_args(content_or_attrs, maybe_content, __CALLER__)
    content = {{:., [], [{:__aliases__, [alias: false], [:List]}, :wrap]}, [], [content]}
    assigns = {:%{}, [], [{:__content__, content} | attrs]}
    template = :row__template
    :elixir_quote.dot([], Element, template, [assigns], Element)
  end

  defmacro row(x0) do
    super(x0, nil)
  end

  defmacro row() do
    super(nil, nil)
  end

  def column__template(assigns) do
    (
      Marker.HTML

      (
        Kernel
        Marker.HTML
      )
    )

    _ = assigns

    (
      IO.inspect(Map.get(assigns, :assigns))
      IO.inspect(Map.get(assigns, :id), label: "id")

      default_attrs = [
        class:
          <<case(Map.get(assigns, :class)) do
              x when :erlang.orelse(:erlang."=:="(x, false), :erlang."=:="(x, nil)) ->
                ""

              x ->
                x
            end::binary(), " flex flex-col">>
      ]

      imported_attrs =
        IO.inspect(
          Enum.filter(:maps.to_list(assigns), fn
            {:__content__, v} ->
              false

            {k, v} ->
              true
          end),
          label: "imported_attrs"
        )

      attrs =
        Keyword.merge(default_attrs, imported_attrs, fn
          k, v1, v2 when :erlang.andalso(:erlang.is_binary(v1), :erlang.is_binary(v2)) ->
            <<v1::binary(), " ", v2::binary()>>

          _, _, v2 ->
            v2
        end)

      {:safe,
       Marker.Compiler.concat(
         :lists.reverse([
           "</div>"
           | (
               expr = Marker.Encoder.encode(Map.get(assigns, :__content__))

               [
                 expr
                 | [
                     ">"
                     | Enum.reduce(attrs, ["<div" | []], fn
                         {_, nil}, chunks ->
                           chunks

                         {_, false}, chunks ->
                           chunks

                         {k, true}, chunks ->
                           Marker.Compiler.enabled_attr(chunks, k)

                         {k, v}, chunks ->
                           Marker.Compiler.attr(chunks, k, v)
                       end)
                   ]
               ]
             )
         ])
       )}
    )
  end

  defmacro column(content_or_attrs, maybe_content) do
    {attrs, content} = Marker.Element.normalize_args(content_or_attrs, maybe_content, __CALLER__)
    content = {{:., [], [{:__aliases__, [alias: false], [:List]}, :wrap]}, [], [content]}
    assigns = {:%{}, [], [{:__content__, content} | attrs]}
    template = :column__template
    :elixir_quote.dot([], Element, template, [assigns], Element)
  end

  defmacro column(x0) do
    super(x0, nil)
  end

  defmacro column() do
    super(nil, nil)
  end
end