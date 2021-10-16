defmodule GoldenWeb.MarkerView do
  use GoldenWeb, :view

  import ElmView
  alias ElmView.Input
  require ElmView

  @dom column([spacing: 2], [
         text(["Hello There ", {:title, &String.upcase/1}]),
         row([spacing: 4], [
           text("<-"),
           text("->")
         ])
         #  Input.text(
         #    [form: :form, id: :name],
         #    [],
         #    Input.label_above([], "Above")
         #  )
         #  Input.text(
         #    [id: "t"],
         #    Input.label_below([], "Below")
         #  ),
         #  Input.text(
         #    [id: "f"],
         #    Input.label_left([], "Left")
         #  ),
         #  Input.text(
         #    [id: "g"],
         #    Input.label_right([], "Right")
         #  )
       ])
       |> ElmView.render()

  def index(assigns) do
    compile(@dom)
  end

  def render("index.html", assigns), do: index(%{title: "Let's go"})
end
