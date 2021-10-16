defmodule ElmView do
  alias ElmView.Helpers

  def __using__(_) do
    quote do
      require ElmView
      import ElmView
    end
  end

  defprotocol Renderer do
    def render(value, prefix \\ "@")
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
    def render(column, prefix) do
      :div
      |> ElmView.Attributes.to_html(
        @default,
        column.attr,
        reject_attr: @reject_attr,
        children: ElmView.expand_children(column, prefix)
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
    def render(row, prefix) do
      ElmView.Attributes.to_html(
        :div,
        @default,
        row.attr,
        reject_attr: @reject_attr,
        children: ElmView.expand_children(row, prefix)
      )
    end
  end

  def row(attr, children) when is_list(attr) and is_list(children) do
    %Row{attr: attr, children: children}
  end

  defmodule El do
    defstruct attr: [], children: []
  end

  defimpl Renderer, for: El do
    # @default [class: "flex items-center justify-center"]
    @default []
    @reject_attr []
    def render(el, prefix) do
      ElmView.Attributes.to_html(
        :div,
        @default,
        el.attr,
        reject_attr: @reject_attr,
        children: ElmView.expand_children(el, prefix)
      )
    end
  end

  def el(attr, child) when is_list(attr) do
    %El{attr: attr, children: [child]}
  end

  defmodule Link do
    defstruct attr: [], children: [], url: ""
  end

  defimpl Renderer, for: Link do
    @default [class: "text-indigo-600 hover:text-indigo-900"]
    @reject_attr []
    def expand(url, prefix) when is_atom(url) do
      "{#{prefix}#{url}}"
    end

    def expand(url, _) when is_binary(url) do
      url
    end

    def render(link, prefix) do
      ElmView.Attributes.to_html(
        :a,
        @default ++ [href: expand(link.url, prefix)],
        link.attr,
        reject_attr: @reject_attr,
        children: ElmView.expand_children(link, prefix)
      )
    end
  end

  def link(attr, child, url) when is_list(attr) do
    %Link{attr: attr, children: [child], url: url}
  end

  def live_redirect(attr, child, url) when is_list(attr) do
    %Link{
      attr: ["data-phx-link": "redirect", "data-phx-link-state": "push"] ++ attr,
      children: [child],
      url: url
    }
  end

  def live_patch(attr, child, url) when is_list(attr) do
    %Link{
      attr: ["data-phx-link": "patch", "data-phx-link-state": "push"] ++ attr,
      children: [child],
      url: url
    }
  end

  defmodule Image do
    defstruct attr: [], src: "", description: ""
  end

  defimpl Renderer, for: Image do
    def decode_url(url, prefix) when is_atom(url) do
      "{#{prefix}#{url}}"
    end

    def decode_url(url, prefix) when is_binary(url) do
      url
    end

    @default [class: ""]
    @reject_attr []
    def render(image, prefix) do
      img =
        ElmView.Attributes.to_html(
          :img,
          @default ++
            [
              src: decode_url(:image, prefix),
              alt: image.description
            ],
          image.attr,
          reject_attr: @reject_attr
        )

      """
      <div class="flex-shrink-0 h-10 w-10">
        #{img}
      </div>
      """
    end
  end

  def image(attr, src, description \\ "") when is_list(attr) do
    %Image{attr: attr, src: src, description: description}
  end

  defmodule Raw do
    defstruct content: ""
  end

  defimpl Renderer, for: Raw do
    def render(raw, _) do
      raw.content
    end
  end

  def raw(content) do
    %Raw{content: content}
  end

  defmodule Text do
    defstruct attr: [], content: "", type: "span"
  end

  defimpl Renderer, for: Text do
    def expand(content, prefix) do
      content
      |> Enum.map(fn
        str when is_binary(str) ->
          Helpers.escape(str)

        key when is_atom(key) ->
          "<%= #{prefix}#{key} |> ElmView.Helpers.escape() %>"

        {key, func} when is_atom(key) and is_function(func, 1) ->
          "<%= #{prefix}#{key}|> then(#{Kernel.inspect(func)}) |> ElmView.Helpers.escape() %>"
      end)
      |> Enum.join("")
    end

    def render(text) do
      "<#{text.type}>" <> expand(text.content, "@") <> "</#{text.type}>"
    end

    def render(text, prefix) do
      "<#{text.type}>" <> expand(text.content, prefix) <> "</#{text.type}>"
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
      content: content
    }
  end

  defimpl Renderer, for: BitString do
    def render(str, _), do: str
  end

  defmodule Table do
    defstruct attr: [], data: [], columns: []
  end

  defmodule TableColumn do
    defstruct title: nil,
              header:
                "<th scope='col' class='px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider'>Name</th>",
              width: nil,
              view: nil
  end

  def tableColumn(title, view \\ ElmView.text("sdas")) do
    %TableColumn{
      title: String.downcase(title),
      header:
        "<th scope='col' class='px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider'>#{title}</th>",
      view: view
    }
  end

  defimpl Renderer, for: Table do
    @default [class: "flex flex-col"]
    @reject_attr [:spacing_x]
    def render_header(%TableColumn{} = column) do
      column.header
    end

    def render_row(row, column) do
      """
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
        <%= row.name %>
      </td>

            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
              <a href="#" class="text-indigo-600 hover:text-indigo-900">Edit</a>
            </td>

      """
    end

    def render(table, prefix) do
      headers =
        table.columns
        |> Enum.map(&render_header/1)
        |> Enum.join("")

      row_details =
        table.columns
        |> Enum.with_index()
        |> Enum.map(fn {col, index} ->
          """
          <td class="px-6 py-4 whitespace-nowrap">
            #{ElmView.Renderer.render(col.view, "row.")}
          </td>
          """
        end)
        |> Enum.join("")

      get_row = "@#{table.data |> elem(0)}"
      transform_row = Kernel.inspect(table.data |> elem(1))

      rows = "#{get_row} |> then(#{transform_row})"

      """
      <div class="align-middle inline-block min-w-full shadow overflow-x-auto sm:rounded-lg border-b border-gray-200">
        <table class="w-full divide-y divide-gray-200  border-b border-gray-200 shadow sm:rounded-lg">
          <thead class="bg-gray-50">
            <tr>#{headers}</tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">

            <%= for {row, index} <- #{rows} |> Enum.with_index() do %>
              <tr>
              #{row_details}
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
      """

      # <>
      # """
      # </div>
      # </div>
      # """
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
    Renderer.render(item, "@")
  end

  def expand_children(%{children: children}, prefix) do
    Enum.reduce(children, "", fn child, acc ->
      acc <> Renderer.render(child, prefix)
    end)
  end

  def expand_children(children, prefix) do
    Enum.reduce(children, "", fn child, acc ->
      acc <> Renderer.render(child, prefix)
    end)
  end
end
