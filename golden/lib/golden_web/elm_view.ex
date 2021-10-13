defmodule ElmView do
  def expand(arg, env) do
    Macro.prewalk(arg, &Macro.expand_once(&1, env))
  end

  defmacro compile(str) do
    options = [
      engine: Phoenix.LiveView.HTMLEngine,
      file: __CALLER__.file,
      line: __CALLER__.line + 1,
      module: __CALLER__.module
    ]

    EEx.compile_string(ElmView.expand(str, __CALLER__) |> IO.inspect(), options)
  end

  for text_node <- ~w[h1 h2 h3 h4 h5 h6]a do
    defmacro unquote(text_node)(title) do
      "<#{unquote(text_node)}><%=@#{title}%></#{unquote(text_node)}>"
    end
  end

  defmacro text(text_) when is_binary(text_) do
    "<span>#{ElmView.expand(text_, __CALLER__)}</span>"
  end

  defmacro text(text_) do
    "<span><%= @#{ElmView.expand(text_, __CALLER__)}%></span>"
  end

  defmacro column(attr, children) when is_list(attr) and is_list(children) do
    "<div class='flex flex-col items-center'>" <>
      (children
       |> Enum.reduce("", fn chunk, acc ->
         acc <> ElmView.expand(chunk, __CALLER__)
       end)) <>
      "</div>"
  end
end
