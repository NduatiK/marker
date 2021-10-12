defmodule Element do
  use Marker
  require Marker.HTML

  Marker.component :column do
    div class: (@class || "") <> " flex flex-col" do
      @__content__
    end
  end

  Marker.component :row do
    div class: (@class || "") <> " flex flex-row items-center" do
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
