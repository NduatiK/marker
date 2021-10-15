defmodule ElmView.Attributes do
  alias ElmView.Renderer
  @mergeable [:class]
  @unclosed ["input"]

  def merge(defaults, attr) do
    Keyword.merge(defaults, attr, fn
      k, old, new when k in @mergeable and is_binary(old) and is_binary(new) ->
        old <> " " <> new

      _, _, new ->
        new
    end)
  end

  def parse_attrs(attrs, reject_attr) do
    attrs
    |> Enum.flat_map(&parse_attr/1)
    |> Enum.flat_map_reduce([], fn {k, v}, acc ->
      if k not in reject_attr do
        {v, merge(acc, v)}
      else
        {[], acc}
      end
    end)
    |> elem(1)
  end

  def parse_attr({:padding_x, size}) when is_integer(size) do
    [{:padding_x, [class: "px-#{size}"]}]
  end

  def parse_attr({:padding_y, size}) when is_integer(size) do
    [{:padding_y, [class: "py-#{size}"]}]
  end

  def parse_attr({:padding, size}) when is_integer(size) do
    [padding_x: size, padding_y: size]
    |> Enum.flat_map(&parse_attr/1)
  end

  def parse_attr({:spacing_x, size}) when is_integer(size) do
    [{:spacing_x, [class: "space-x-#{size}"]}]
  end

  def parse_attr({:spacing_y, size}) when is_integer(size) do
    [{:spacing_y, [class: "space-y-#{size}"]}]
  end

  def parse_attr({:spacing, size}) when is_integer(size) do
    [spacing_x: size, spacing_y: size]
    |> Enum.flat_map(&parse_attr/1)
  end

  def parse_attr({key, value}) when is_binary(value) do
    [{key, [{key, value}]}]
  end

  def parse_attr(_, _) do
    []
  end

  def to_html(tag, default_attrs, attrs, reject_attr: reject_attr, children: children) do
    default_attrs
    |> parse_attrs(reject_attr)
    |> merge(
      attrs
      |> parse_attrs(reject_attr)
    )
    |> Enum.reduce("<#{tag}", fn {k, v}, acc ->
      acc <> " #{k}='#{v}'"
    end)
    |> then(fn chunk ->
      if "#{tag}" in @unclosed do
        chunk <> ">"
      else
        chunk <> ">#{children}</#{tag}>"
      end
    end)
  end

  def to_html(tag, default_attrs, attrs, children: children) do
    to_html(tag, default_attrs, attrs,
      reject_attr: [],
      children: children
    )
  end

  def to_html(tag, default_attrs, attrs, reject_attr: reject_attr) do
    to_html(tag, default_attrs, attrs,
      reject_attr: reject_attr,
      children: []
    )
  end

  def to_html(tag, default_attrs, attrs) do
    to_html(tag, default_attrs, attrs,
      reject_attr: [],
      children: []
    )
  end
end
