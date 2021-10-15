defmodule GoldenWeb.MarkerView do
  def template_not_found(template, assigns) do
    Phoenix.Template.raise_template_not_found(GoldenWeb.MarkerView, template, assigns)
  end

  defp render_template(template, %{__phx_render_existing__: {GoldenWeb.MarkerView, template}}) do
    nil
  end

  defp render_template(template, %{__phx_template_not_found__: GoldenWeb.MarkerView} = assigns) do
    Phoenix.Template.raise_template_not_found(GoldenWeb.MarkerView, template, assigns)
  end

  defp render_template(template, assigns) do
    template_not_found(
      template,
      :maps.put(:__phx_template_not_found__, GoldenWeb.MarkerView, assigns)
    )
  end

  def render(module, template) do
    Phoenix.View.render(module, template, %{})
  end

  def render(template, _assigns) do
    :erlang.error(
      ArgumentError.exception(
        <<"render/2 expects template to be a string, got: ", Kernel.inspect(template)::binary()>>
      )
    )
  end

  def render(template, assigns) do
    render(template, Enum.into(assigns, %{}))
  end

  def render("index.html", assigns) do
    index(%{title: "Let's go"})
  end

  def render(template, assigns) do
    render_template(template, assigns)
  end

  def render(x0) do
    super(x0, %{})
  end

  def index(assigns) do
    Phoenix.LiveView.Helpers

    (
      Phoenix.LiveView.Engine

      (
        dynamic = fn track_changes? ->
          changed =
            case(assigns) do
              %{__changed__: changed} when track_changes? ->
                changed

              _ ->
                nil
            end

          arg0 =
            case(Phoenix.LiveView.Engine.changed_assign?(changed, :title)) do
              true ->
                Phoenix.LiveView.Engine.live_to_iodata(
                  String.upcase(Phoenix.LiveView.Engine.fetch_assign!(assigns, :title))
                )

              false ->
                nil
            end

          [arg0]
        end

        %Phoenix.LiveView.Rendered{
          static: [
            "<div class='flex flex-col items-center'><span>Hello</span><span>There</span><span>Hello There</span><span>Hello There ",
            "</span></div>"
          ],
          dynamic: dynamic,
          fingerprint: 160_426_268_321_480_674_266_697_170_934_817_320_176,
          root: true
        }
      )
    )
  end

  def __templates__() do
    {"lib/golden_web/templates/marker", "*", []}
  end

  def __resource__() do
    :marker
  end

  def __mix_recompile__?() do
    :erlang."/="(
      <<212, 29, 140, 217, 143, 0, 178, 4, 233, 128, 9, 152, 236, 248, 66, 126>>,
      Phoenix.Template.hash("lib/golden_web/templates/marker", "*", %{
        eex: Phoenix.Template.EExEngine,
        exs: Phoenix.Template.ExsEngine,
        heex: Phoenix.LiveView.HTMLEngine,
        leex: Phoenix.LiveView.Engine
      })
    )
  end
end