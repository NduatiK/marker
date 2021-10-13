defmodule ElmView do
  defmacro h2(title) do
    <<"<h2><%=", String.Chars.to_string(title)::binary(), "%></h2>">>
  end

  def expand(arg, env) do
    Macro.prewalk(arg, fn x1 -> Macro.expand_once(x1, env) end)
  end

  defmacro compile(str) do
    options = [
      engine: Phoenix.LiveView.HTMLEngine,
      file: __CALLER__.file,
      line: :erlang.+(__CALLER__.line, 1),
      module: __CALLER__.module
    ]

    EEx.compile_string(IO.inspect(ElmView.expand(str, __CALLER__)), options)
  end

  defmacro column(attr, children) do
    <<"<div class='flex flex-row items-center'>",
      Enum.reduce(children, "", fn child, acc ->
        {:<>, [context: ElmView, import: Kernel], [acc, child]}
      end)::binary(), "</div>">>
  end
end