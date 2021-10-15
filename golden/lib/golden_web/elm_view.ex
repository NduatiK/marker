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
    options = [
      engine: Phoenix.LiveView.HTMLEngine,
      file: __CALLER__.file,
      line: __CALLER__.line + 1,
      module: __CALLER__.module
    ]

    EEx.compile_string(ElmView.expand(tree, __CALLER__), options)
  end

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

  defmodule Table do
    defstruct attr: [], data: [], columns: []
  end

  defmodule TableColumn do
    defstruct header:
                "<th scope='col' class='px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider'>Name</th>",
              width: nil,
              view: nil
  end

  def tableColumn(title) do
    %TableColumn{
      header:
        "<th scope='col' class='px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider'>#{title}</th>"
    }
  end

  defimpl Renderer, for: Table do
    @default [class: "flex flex-col"]
    @reject_attr [:spacing_x]
    def render_header(%TableColumn{} = column) do
      column.header
    end

    def render_row(row) do
      """
            <tr>
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="flex items-center">
                <div class="flex-shrink-0 h-10 w-10">
                  <img class="h-10 w-10 rounded-full" src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=4&w=256&h=256&q=60" alt="">
                </div>
                <div class="ml-4">
                  <div class="text-sm font-medium text-gray-900">
                    #{row.name}
                    </div>
                    <div class="text-sm text-gray-500">
                    #{row.email}
                  </div>
                </div>
              </div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="text-sm text-gray-900">Regional Paradigm Technician</div>
              <div class="text-sm text-gray-500">Optimization</div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                Active
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
              Admin
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
              <a href="#" class="text-indigo-600 hover:text-indigo-900">Edit</a>
            </td>
          </tr>
      """
    end

    def render(table) do
      IO.inspect(table)
      # table =
      #   ElmView.Attributes.to_html(
      #     :div,
      #     @default,
      #     column.attr,
      #     reject_attr: @reject_attr,
      #     children: ElmView.expand_children(column)
      #   )

      # (Enum.map(table.rows, &render_row/1)
      #  |> Enum.join("")) <>
      # "  <p><%= render_row(row) %></p>" <>
      # "  <p><%= ElmView.Renderer.ElmView.Table.render_row(row) %></p>" <>
      """
      <div class="flex flex-col">
      <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
      <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
      <div class="shadow overflow-hidden border-b border-gray-200 sm:rounded-lg">
      """ <>
        """
        <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50">
        <tr>
        """ <>
        (Enum.map(table.columns, &render_header/1)
         |> Enum.join("")
         |> IO.inspect()) <>
        "</tr></thead><tbody>" <>
        ("<%= for row <- (@#{table.data |> elem(0)} |> then(#{Kernel.inspect(table.data |> elem(1))})) do %>"
         |> IO.inspect()) <>
        "<%= {:safe, #{__MODULE__}.render_row(row)} %>" <>
        "<% end %>" <>
        """
          </tbody>
        </table>
        """ <>
        """
        </div>
        </div>
        </div>
        </div>
        """
    end
  end

  def table(attr, data: data, columns: columns) when is_list(attr) do
    %Table{
      attr: attr,
      data: data,
      columns: columns
    }
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
