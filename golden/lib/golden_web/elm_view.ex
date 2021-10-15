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

    # quote do
    #   EEx.compile_string(unquote(tree), unquote(options))
    # end
    # ElmView.expand(str, __CALLER__)
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
    def render(column) do
      children =
        Enum.reduce(column.children, "", fn child, acc ->
          acc <> Renderer.render(child)
        end)

      "<div class='flex flex-col items-center'" <>
        ">" <>
        children <>
        "</div>"
    end
  end

  def column(attr, children) when is_list(attr) and is_list(children) do
    %Column{attr: attr, children: children}
  end

  defmodule Row do
    defstruct attr: [], children: []
  end

  defimpl Renderer, for: Row do
    def render(row) do
      children =
        Enum.reduce(row.children, "", fn child, acc ->
          acc <> Renderer.render(child)
        end)

      "<div class='flex items-center'" <>
        ">" <>
        children <>
        "</div>"
    end
  end

  def row(attr, children) when is_list(attr) and is_list(children) do
    %Row{attr: attr, children: children}
  end

  defmodule Text do
    defstruct attr: [], content: ""
  end

  defimpl Renderer, for: Text do
    def render(text) do
      "<span>" <> text.content <> "</span>"
    end
  end

  def text(content) when is_binary(content) or is_atom(content) do
    text([content])
  end

  def text({key, func} = content) when is_atom(key) or is_function(func, 1) do
    text([content])
  end

  def text(content) when is_list(content) do
    %Text{
      attr: [],
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
end
