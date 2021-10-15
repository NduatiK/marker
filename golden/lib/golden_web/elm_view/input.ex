defmodule ElmView.Input do
  alias ElmView.Renderer

  defmodule Button do
    defstruct attr: [], on_click: nil, label: []
  end

  defimpl Renderer, for: Button do
    def render(button) do
      "<button class='' phx-click={@click}>" <>
        Renderer.render(button.label) <>
        "</button> "
    end
  end

  def button(attr, on_click, label) when is_list(attr) do
    %Button{attr: attr, label: label}
  end

  defmodule Label do
    defstruct position: :above, label: [], attr: []
  end

  defimpl Renderer, for: Label do
    def render(label) do
      "<label class='flex text-sm font-medium text-gray-700'>" <>
        Renderer.render(label.label) <>
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
    def render(label) do
      "<input class='focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-3 pr-3 sm:text-sm border-gray-300 rounded-md'" <>
        "type='text'>"
    end
  end

  def text(attr, label) when is_list(attr) do
    # input_ = %Text{attr: attr,label: label, content: content}
    input_ = %Text{attr: attr, label: label}
    input_label = label
    container_attr = []

    case label.position do
      :above ->
        ElmView.column(container_attr ++ [{:class, "mt-1 w-full max-w-xs"}], [
          input_label,
          input_
        ])

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
  end
end
