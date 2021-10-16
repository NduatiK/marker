defmodule ElmView.Attributes do
  alias ElmView.Renderer
  @mergeable [:class]
  @positioned_div [:in_front, :above, :below, :behind_content, :on_left, :on_right]
  @repeatable @positioned_div ++ []
  @unclosed ["input", "img"]

  def merge(defaults, attr) do
    Keyword.merge(defaults, attr, fn
      k, old, new when k in @mergeable and is_binary(old) and is_binary(new) ->
        old <> " " <> new

      _, _, new ->
        new
    end)
  end

  def split(attr_and_divs) do
    attr_and_divs
    |> Enum.reduce({[], []}, fn
      {k, v}, {attr, divs} when k in @positioned_div ->
        {attr, divs ++ [{k, v}]}

      {k, v}, {attr, divs} ->
        {attr ++ [{k, v}], divs}
    end)
  end

  def parse_attrs(attrs, reject_attr) do
    attrs
    |> Enum.flat_map(&parse_attr/1)
    |> Enum.flat_map_reduce([], fn {k, v}, acc ->
      cond do
        k in reject_attr ->
          {[], acc}

        k in @positioned_div ->
          {v, acc ++ v}

        true ->
          {v, merge(acc, v)}
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

  def parse_attr({key, value}) when key in @positioned_div do
    [{key, [{key, value}]}]
  end

  # def parse_attr(_, _) do
  #   []
  # end

  def positioned_to_div({:above, el}) do
    "<div class='z-10 absolute'>#{ElmView.render(el)}</div>"
  end

  def to_html(tag, default_attrs, attrs, reject_attr: reject_attr, children: children) do
    {attr, divs} =
      default_attrs
      |> parse_attrs(reject_attr)
      |> merge(
        attrs
        |> parse_attrs(reject_attr)
      )
      |> split()

    divs_html =
      Enum.reduce(divs, "", fn div, acc ->
        acc <> positioned_to_div(div)
      end)

    html =
      attr
      |> Enum.reduce("<#{tag}", fn {k, v}, acc ->
        if String.starts_with?(v, "{") do
          acc <> " #{k}=#{v}"
        else
          acc <> " #{k}='#{v}'"
        end
      end)
      |> then(fn chunk ->
        if "#{tag}" in @unclosed do
          chunk <> ">"
        else
          chunk <> ">#{children}</#{tag}>"
        end
      end)

    if Enum.empty?(divs) do
      html
    else
      "<div class='relative flex w-auto'>#{html}#{divs_html}</div>"
    end
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
