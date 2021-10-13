defmodule Element do
  use Marker
  require Marker.HTML

  def merge_attr(default_attrs, assigns) do
    imported_attrs =
      assigns
      |> Map.to_list()
      |> Enum.filter(fn
        {:__content__, v} -> false
        {k, v} -> true
      end)

    attrs =
      Keyword.merge(default_attrs, imported_attrs, fn
        k, v1, v2 when is_binary(v1) and is_binary(v2) ->
          v1 <> " " <> v2

        _, _, v2 ->
          v2
      end)
  end

  Marker.component :column do
    default_attrs = [class: (@class || "") <> " flex flex-col"]
    attrs = merge_attr(default_attrs, assigns)

    div attrs do
      @__content__
    end
  end

  Marker.component :row do
    default_attrs = [class: (@class || "") <> " flex flex-row items-center"]

    attrs = merge_attr(default_attrs, assigns)

    div attrs do
      @__content__
    end
  end

  # defmodule Attributes do
  def shrink(), do: "flex-initial"

  defmacro spacing_x(space) when is_integer(space), do: quote(do: unquote(" space-x-#{space} "))
  defmacro spacing_y(space) when is_integer(space), do: quote(do: unquote(" space-y-#{space} "))

  defmacro spacing(space) when is_integer(space),
    do: quote(do: unquote(" space-x-#{space} space-y-#{space} "))

  defmacro spacing_xy(x, y) when is_integer(x) and is_integer(y),
    do: quote(do: unquote(" space-x-#{x} space-y-#{y} "))
end
