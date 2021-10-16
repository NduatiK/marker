defmodule ElmView.Input do
  alias ElmView.Renderer

  defmodule Button do
    defstruct attr: [], on_press: nil, label: [], target: nil
  end

  defimpl Renderer, for: Button do
    def render(button, prefix) do
      :button
      |> ElmView.Attributes.to_html(
        [
          class: "bg-blue-50 hover:bg-blue-100 text-blue-700 font-semibold py-2 px-4 rounded",
          "phx-click": "#{button.on_press}"
        ],
        button.attr,
        reject_attr: [],
        children: ElmView.expand_children([button.label], prefix)
      )
    end
  end

  def button(attr, on_press: on_press, label: label)
      when is_list(attr) and is_atom(on_press) do
    %Button{attr: attr, label: label, on_press: on_press}
  end

  def button(attr, on_press: {on_press, target}, label: label)
      when is_list(attr) and is_atom(on_press) and is_atom(target) do
    %Button{attr: attr, label: label, on_press: on_press, target: target}
  end

  defmodule Label do
    defstruct position: :above, label: [], attr: []
  end

  defimpl Renderer, for: Label do
    def render(label, prefix) do
      "<label class='flex text-sm font-medium text-gray-700'>" <>
        Renderer.render(label.label, prefix) <>
        "</label> "
    end
  end

  for position <- ~w[left right above below]a do
    def unquote(String.to_atom("label_" <> Atom.to_string(position)))(attr, content)
        when is_list(attr) do
      %Label{attr: attr, position: unquote(position), label: content}
    end
  end

  defmodule Text do
    defstruct attr: [], label: nil
  end

  defimpl Renderer, for: Text do
    @spec render(%ElmView.Input.Text{}, any) :: nonempty_binary
    def render(label, prefix) do
      default = [
        class:
          "focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-3 pr-3 sm:text-sm border-gray-300 rounded-md",
        type: "text"
      ]

      ElmView.Attributes.to_html("input", default, label.attr)
    end
  end

  @doc """
  Input.text(
    [id: "name"],
    Input.label_above([], "Above")
  )
  """
  def text([form: form, id: id], attr, input_label) when is_list(attr) do
    # input_ = %Text{attr: attr, label: input_label}
    input_ = %Text{attr: attr, label: input_label}

    input_attr =
      input_.attr ++
        [
          id: "#{form}_#{id}",
          name: "#{form}[#{id}]",
          value: "{#{form}.source.changes[:#{id}]||#{form}.source.data.#{id}}"
        ]

    input_ = %{input_ | attr: input_attr}

    error = ElmView.raw("<%= error_tag #{form}, :#{id} %>")
    container_attr = [spacing: 2]

    input_and_label =
      case input_label.position do
        :above ->
          ElmView.column(container_attr ++ [{:class, "mt-1 w-full max-w-xs"}], [
            input_label,
            input_
          ])
          |> IO.inspect()

        :below ->
          ElmView.column(container_attr ++ [{:class, "mt-1 w-full max-w-xs"}], [
            input_,
            input_label
          ])

        :left ->
          ElmView.row(container_attr ++ [{:class, "mt-1 w-full max-w-xs"}], [
            input_label,
            input_
          ])

        :right ->
          ElmView.row(container_attr ++ [{:class, "mt-1 w-full max-w-xs"}], [
            input_,
            input_label
          ])
      end

    ElmView.column(container_attr ++ [{:class, "mt-1 w-full max-w-xs"}], [
      input_and_label,
      error
    ])
  end

  defmodule Form do
    defstruct changeset: nil,
              on_change: nil,
              on_submit: nil,
              target: nil,
              id: nil,
              path_on_submit: "#",
              attr: [],
              children: []
  end

  defimpl Renderer, for: Form do
    def render(form, prefix) do
      # "<%= form_for @#{form.changeset}, \"#{form.path_on_submit}\", #{inspect(form.opts)}, fn f -> %>" <>
      ("""
       <.form let={f} for={@#{form.changeset}} phx-change="#{form.on_change}" phx-submit="#{form.on_submit}" #{if form.target, do: "phx-target={@#{form.target}}", else: ""}>
       """ <>
         ElmView.expand_children(form, prefix) <>
         "</.form>")
      |> IO.inspect()
    end
  end

  @doc """
  Input.form(
    :changeset,
    "#"
    [],
    [Input.text(...)]
  )
  """
  def form(
        %{
          id: id,
          target: target,
          changeset: changeset,
          on_change: on_change,
          on_submit: on_submit
        },
        path_on_submit,
        attr,
        children
      )
      when is_list(children) do
    %Form{
      changeset: changeset,
      path_on_submit: path_on_submit,
      on_change: on_change,
      on_submit: on_submit,
      target: target,
      id: id,
      attr: attr,
      children: children
    }
  end
end
