defmodule ElmView do
  alias ElmView.Helpers

  def __using__(_) do
    quote do
      require ElmView
      import ElmView
    end
  end

  defprotocol Renderer do
    def render(value)
  end

  def expand(arg, env) do
    Macro.prewalk(arg, &Macro.expand_once(&1, env))
  end

  defmacro compile(tree) do
    env = __CALLER__

    options = [
      engine: Phoenix.LiveView.HTMLEngine,
      file: __CALLER__.file,
      line: __CALLER__.line + 1,
      module: __CALLER__.module
    ]

    EEx.compile_string(ElmView.expand(tree, __CALLER__), options)
  end

  # for text_node <- ~w[h1 h2 h3 h4 h5 h6]a do
  #   defmacro unquote(text_node)(title) do
  #     "<#{unquote(text_node)}><%=@#{title}%></#{unquote(text_node)}>"
  #   end
  # end

  # defmacro text(text_) when is_binary(text_) do
  #   "<span>#{ElmView.expand(text_, __CALLER__)}</span>"
  # end

  # defmacro text(text_) do
  #   "<span><%= @#{ElmView.expand(text_, __CALLER__)}%></span>"
  # end

  defmodule Column do
    defstruct attr: [], children: []
  end

  defimpl Renderer, for: Column do
    @default [class: "flex flex-col"]
    @reject_attr [:spacing_x]
    def render(column) do
      :div
      |> ElmView.Attributes.to_html(
        @default,
        column.attr,
        reject_attr: @reject_attr,
        children: ElmView.expand_children(column)
      )
    end
  end

  def column(attr, children) when is_list(attr) and is_list(children) do
    %Column{attr: attr, children: children}
  end

  defmodule Row do
    defstruct attr: [], children: []
  end

  defimpl Renderer, for: Row do
    @default [class: "flex items-center"]
    @reject_attr [:spacing_y]
    def render(row) do
      ElmView.Attributes.to_html(
        :div,
        @default,
        row.attr,
        reject_attr: @reject_attr,
        children: ElmView.expand_children(row)
      )
    end
  end

  def row(attr, children) when is_list(attr) and is_list(children) do
    %Row{attr: attr, children: children}
  end

  defmodule Text do
    defstruct attr: [], content: "", type: "span"
  end

  defimpl Renderer, for: Text do
    def render(text) do
      "<#{text.type}>" <> text.content <> "</#{text.type}>"
    end
  end

  for type <- ~w[h1 h2 h3 h4 h5 h6]a do
    def text(unquote(type), content) do
      do_text(unquote(type), content)
    end
  end

  def text(content), do: text(:body, content)

  def text(:body, content), do: do_text(:span, content)

  defp do_text(type, content) when is_binary(content) or is_atom(content) do
    do_text(type, [content])
  end

  defp do_text(type, {key, func} = content) when is_atom(key) or is_function(func, 1) do
    do_text(type, [content])
  end

  defp do_text(type, content) when is_list(content) do
    %Text{
      attr: [],
      type: type,
      content:
        content
        |> Enum.map(fn
          str when is_binary(str) ->
            Helpers.escape(str)

          key when is_atom(key) ->
            "<%= @#{key} |> ElmView.Helpers.escape() %>"

          {key, func} when is_atom(key) and is_function(func, 1) ->
            "<%= @#{key}|> then(#{Kernel.inspect(func)}) |> ElmView.Helpers.escape() %>"
        end)
        |> Enum.join("")
    }
  end

  defimpl Renderer, for: BitString do
    def render(str), do: str
  end

  def render(item) do
    Renderer.render(item)
  end

  def expand_children(%{children: children}) do
    Enum.reduce(children, "", fn child, acc ->
      acc <> Renderer.render(child)
    end)
  end

  def expand_children(children) do
    Enum.reduce(children, "", fn child, acc ->
      acc <> Renderer.render(child)
    end)
  end
end
