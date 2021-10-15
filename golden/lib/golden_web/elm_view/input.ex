defmodule ElmView.Input do
  alias ElmView.Renderer

  defmodule Button do
    defstruct attr: [], on_press: nil, label: [], target: nil
  end

  defimpl Renderer, for: Button do
    def render(button) do
      "<button class='bg-blue-50 hover:bg-blue-100 text-blue-700 font-semibold py-2 px-4 rounded' phx-click='#{button.on_press}' " <>
        if(button.target, do: "phx-target={@#{button.target}}", else: "") <>
        ">" <>
        Renderer.render(button.label) <>
        "</button> "
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
      default = [
        class:
          "focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-3 pr-3 sm:text-sm border-gray-300 rounded-md",
        type: "text"
      ]

      ElmView.Attributes.to_html("input", default, [])
    end
  end

  def text(attr, label) when is_list(attr) do
    input_ = %Text{attr: attr, label: label}
    input_label = label
    container_attr = [spacing: 2]

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
