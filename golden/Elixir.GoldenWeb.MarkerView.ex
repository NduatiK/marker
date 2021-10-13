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
    IO.inspect(index(IO.inspect(assigns)))
  end

  def render(template, assigns) do
    render_template(template, assigns)
  end

  def render(x0) do
    super(x0, %{})
  end

  def index3(assigns) do
    greeting =
      (
        msgid = "Welcome to %{name}"
        Gettext.dpgettext(GoldenWeb.Gettext, "default", nil, msgid, name: "Phoenix!")
      )

    {:safe, html} =
      {:safe,
       Marker.Compiler.concat(
         :lists.reverse([
           "</div>"
           | (
               expr =
                 Marker.Encoder.encode(
                   Marker.Compiler.concat(
                     :lists.reverse([
                       "</h2>"
                       | (
                           expr = Marker.Encoder.encode(%{conn: %{host: "asd"}}.conn.host)
                           [expr | [">" | [" class='h2'" | ["<h2" | []]]]]
                         )
                     ])
                   )
                 )

               [
                 expr
                 | (
                     expr =
                       Marker.Encoder.encode(
                         Marker.Compiler.concat(
                           :lists.reverse([
                             "</h2>"
                             | (
                                 expr = Marker.Encoder.encode(greeting)
                                 [expr | [">" | [" class='h2'" | ["<h2" | []]]]]
                               )
                           ])
                         )
                       )

                     [
                       expr
                       | [
                           ">"
                           | [" style='background: #fafafa'" | [" class='p-4'" | ["<div" | []]]]
                         ]
                     ]
                   )
               ]
             )
         ])
       )}

    Marker.Compiler.expand(html, %{
      __struct__: Macro.Env,
      aliases: [{Routes, GoldenWeb.Router.Helpers}, {Input, Element.Input}],
      context: nil,
      context_modules: [GoldenWeb.MarkerView],
      contextual_vars: [],
      current_vars:
        {%{
           {:assigns, nil} => 0,
           {:expr, Marker.Compiler} => 6,
           {:greeting, {GoldenWeb.MarkerView, 53}} => 2,
           {:html, nil} => 7,
           {:msgid, {GoldenWeb.Gettext, 13}} => 1
         },
         %{
           {:assigns, nil} => 0,
           {:expr, Marker.Compiler} => 6,
           {:greeting, {GoldenWeb.MarkerView, 53}} => 2,
           {:html, nil} => 7,
           {:msgid, {GoldenWeb.Gettext, 13}} => 1
         }},
      file: "c:/Users/Hp/Project/marker/golden/lib/golden_web/views/marker_view.ex",
      function: {:index3, 1},
      functions: [
        {Element, [column__template: 1, merge_attr: 2, row__template: 1, shrink: 0]},
        {GoldenWeb.Gettext,
         [
           handle_missing_bindings: 2,
           handle_missing_plural_translation: 6,
           handle_missing_translation: 4,
           lgettext: 4,
           lgettext: 5,
           lngettext: 6,
           lngettext: 7
         ]},
        {GoldenWeb.ErrorHelpers, [error_tag: 2, translate_error: 1]},
        {Phoenix.View,
         [
           render: 3,
           render_existing: 2,
           render_existing: 3,
           render_layout: 4,
           render_many: 3,
           render_many: 4,
           render_one: 3,
           render_one: 4,
           render_to_iodata: 3,
           render_to_string: 3
         ]},
        {GoldenWeb.LiveHelpers, [live_modal: 2]},
        {Phoenix.LiveView.Helpers,
         [
           assigns_to_attributes: 1,
           assigns_to_attributes: 2,
           form: 1,
           live_file_input: 1,
           live_file_input: 2,
           live_flash: 2,
           live_img_preview: 1,
           live_img_preview: 2,
           live_patch: 1,
           live_patch: 2,
           live_redirect: 1,
           live_redirect: 2,
           live_render: 2,
           live_render: 3,
           live_title_tag: 1,
           live_title_tag: 2,
           upload_errors: 1,
           upload_errors: 2
         ]},
        {Phoenix.HTML.Format, [text_to_html: 1, text_to_html: 2]},
        {Phoenix.HTML.Tag,
         [
           attributes_escape: 1,
           content_tag: 2,
           content_tag: 3,
           csrf_input_tag: 1,
           csrf_input_tag: 2,
           csrf_meta_tag: 0,
           csrf_meta_tag: 1,
           csrf_token_value: 0,
           csrf_token_value: 1,
           form_tag: 1,
           form_tag: 2,
           form_tag: 3,
           img_tag: 1,
           img_tag: 2,
           tag: 1,
           tag: 2
         ]},
        {Phoenix.HTML.Link, [button: 2, link: 1, link: 2]},
        {Phoenix.HTML.Form,
         [
           checkbox: 2,
           checkbox: 3,
           color_input: 2,
           color_input: 3,
           date_input: 2,
           date_input: 3,
           date_select: 2,
           date_select: 3,
           datetime_local_input: 2,
           datetime_local_input: 3,
           datetime_select: 2,
           datetime_select: 3,
           email_input: 2,
           email_input: 3,
           file_input: 2,
           file_input: 3,
           form_for: 2,
           form_for: 3,
           form_for: 4,
           hidden_input: 2,
           hidden_input: 3,
           hidden_inputs_for: 1,
           humanize: 1,
           input_id: 2,
           input_id: 3,
           input_name: 2,
           input_type: 2,
           input_type: 3,
           input_validations: 2,
           input_value: 2,
           inputs_for: 2,
           inputs_for: 3,
           inputs_for: 4,
           label: 1,
           label: 2,
           label: 3,
           label: 4,
           multiple_select: 3,
           multiple_select: 4,
           number_input: 2,
           number_input: 3,
           options_for_select: 2,
           password_input: 2,
           password_input: 3,
           radio_button: 3,
           radio_button: 4,
           range_input: 2,
           range_input: 3,
           reset: 1,
           reset: 2,
           search_input: 2,
           search_input: 3,
           select: 3,
           select: 4,
           submit: 1,
           submit: 2,
           telephone_input: 2,
           telephone_input: 3,
           text_input: 2,
           text_input: 3,
           textarea: 2,
           textarea: 3,
           time_input: 2,
           time_input: 3,
           time_select: 2,
           time_select: 3,
           url_input: 2,
           url_input: 3
         ]},
        {Phoenix.HTML, [html_escape: 1, javascript_escape: 1, raw: 1, safe_to_string: 1]},
        {Phoenix.Controller, [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]},
        {Kernel,
         [
           !=: 2,
           !==: 2,
           *: 2,
           +: 1,
           +: 2,
           ++: 2,
           -: 1,
           -: 2,
           --: 2,
           /: 2,
           <: 2,
           <=: 2,
           ==: 2,
           ===: 2,
           =~: 2,
           >: 2,
           >=: 2,
           abs: 1,
           apply: 2,
           apply: 3,
           binary_part: 3,
           bit_size: 1,
           byte_size: 1,
           ceil: 1,
           div: 2,
           elem: 2,
           exit: 1,
           floor: 1,
           function_exported?: 3,
           get_and_update_in: 3,
           get_in: 2,
           hd: 1,
           inspect: 1,
           inspect: 2,
           is_atom: 1,
           is_binary: 1,
           is_bitstring: 1,
           is_boolean: 1,
           is_float: 1,
           is_function: 1,
           is_function: 2,
           is_integer: 1,
           is_list: 1,
           is_map: 1,
           is_map_key: 2,
           is_number: 1,
           is_pid: 1,
           is_port: 1,
           is_reference: 1,
           is_tuple: 1,
           length: 1,
           macro_exported?: 3,
           make_ref: 0,
           map_size: 1,
           max: 2,
           min: 2,
           node: 0,
           node: 1,
           not: 1,
           pop_in: 2,
           put_elem: 3,
           put_in: 3,
           rem: 2,
           round: 1,
           self: 0,
           send: 2,
           spawn: 1,
           spawn: 3,
           spawn_link: 1,
           spawn_link: 3,
           spawn_monitor: 1,
           spawn_monitor: 3,
           struct: 1,
           struct: 2,
           struct!: 1,
           struct!: 2,
           throw: 1,
           tl: 1,
           trunc: 1,
           tuple_size: 1,
           update_in: 3
         ]}
      ],
      lexical_tracker: nil,
      line: 165,
      macro_aliases: [{Routes, {{GoldenWeb.MarkerView, 2}, GoldenWeb.Router.Helpers}}],
      macros: [
        {Element,
         [
           column: 0,
           column: 1,
           column: 2,
           row: 0,
           row: 1,
           row: 2,
           spacing: 1,
           spacing_x: 1,
           spacing_xy: 2,
           spacing_y: 1
         ]},
        {Marker, [component: 2, template: 2]},
        {GoldenWeb.Gettext,
         [
           dgettext: 2,
           dgettext: 3,
           dgettext_noop: 2,
           dngettext: 4,
           dngettext: 5,
           dngettext_noop: 3,
           dpgettext: 3,
           dpgettext: 4,
           dpgettext_noop: 3,
           dpngettext: 5,
           dpngettext: 6,
           dpngettext_noop: 4,
           gettext: 1,
           gettext: 2,
           gettext_comment: 1,
           gettext_noop: 1,
           ngettext: 3,
           ngettext: 4,
           ngettext_noop: 2,
           pgettext: 2,
           pgettext: 3,
           pgettext_noop: 2,
           pngettext: 4,
           pngettext: 5,
           pngettext_noop: 3
         ]},
        {Phoenix.LiveView.Helpers,
         [
           component: 1,
           component: 2,
           component: 3,
           live_component: 1,
           live_component: 2,
           live_component: 3,
           live_component: 4,
           render_block: 1,
           render_block: 2,
           sigil_H: 2,
           sigil_L: 2
         ]},
        {Phoenix.HTML, [sigil_E: 2, sigil_e: 2]},
        {Kernel,
         [
           !: 1,
           &&: 2,
           ..: 2,
           "..//": 3,
           <>: 2,
           @: 1,
           alias!: 1,
           and: 2,
           binding: 0,
           binding: 1,
           def: 1,
           def: 2,
           defdelegate: 2,
           defexception: 1,
           defguard: 1,
           defguardp: 1,
           defimpl: 2,
           defimpl: 3,
           defmacro: 1,
           defmacro: 2,
           defmacrop: 1,
           defmacrop: 2,
           defmodule: 2,
           defoverridable: 1,
           defp: 1,
           defp: 2,
           defprotocol: 2,
           defstruct: 1,
           destructure: 2,
           get_and_update_in: 2,
           if: 2,
           in: 2,
           is_exception: 1,
           is_exception: 2,
           is_nil: 1,
           is_struct: 1,
           is_struct: 2,
           match?: 2,
           or: 2,
           pop_in: 1,
           put_in: 2,
           raise: 1,
           raise: 2,
           reraise: 2,
           reraise: 3,
           sigil_C: 2,
           sigil_D: 2,
           sigil_N: 2,
           sigil_R: 2,
           sigil_S: 2,
           sigil_T: 2,
           sigil_U: 2,
           sigil_W: 2,
           sigil_c: 2,
           sigil_r: 2,
           sigil_s: 2,
           sigil_w: 2,
           tap: 2,
           then: 2,
           to_char_list: 1,
           to_charlist: 1,
           to_string: 1,
           unless: 2,
           update_in: 2,
           use: 1,
           use: 2,
           var!: 1,
           var!: 2,
           |>: 2,
           ||: 2
         ]}
      ],
      module: GoldenWeb.MarkerView,
      prematch_vars: :warn,
      requires: [
        Application,
        Element,
        GoldenWeb,
        GoldenWeb.ErrorHelpers,
        GoldenWeb.Gettext,
        GoldenWeb.LiveHelpers,
        Kernel,
        Kernel.Typespec,
        Marker,
        Marker.HTML,
        Phoenix.Controller,
        Phoenix.HTML,
        Phoenix.HTML.Form,
        Phoenix.HTML.Format,
        Phoenix.HTML.Link,
        Phoenix.HTML.Tag,
        Phoenix.LiveView.Helpers,
        Phoenix.Template,
        Phoenix.View
      ],
      tracers: [],
      unused_vars: {%{{:assigns, 0} => {164, false}, {:html, 7} => false}, 8},
      vars: [assigns: nil]
    })
  end

  defmacro index2(assigns) do
    (
      Marker
      Marker
    )

    Marker.HTML

    {:__block__, [],
     [
       {:=, [],
        [
          {:greeting, [], GoldenWeb.MarkerView},
          {:gettext, [context: GoldenWeb.MarkerView, import: GoldenWeb.Gettext],
           ["Welcome to %{name}", [name: "Phoenix!"]]}
        ]},
       {:=, [],
        [
          {:safe,
           {:var!, [context: GoldenWeb.MarkerView, import: Kernel],
            [{:html, [context: GoldenWeb.MarkerView, import: Marker.HTML], GoldenWeb.MarkerView}]}},
          {{:., [], [{:__aliases__, [alias: false], [:Marker, :HTML]}, :div]}, [],
           [
             [class: "p-4", style: "background: #fafafa"],
             [
               {{:., [], [{:__aliases__, [alias: false], [:Marker, :HTML]}, :h2]}, [],
                [[class: "h2"], {:greeting, [], GoldenWeb.MarkerView}]},
               {:h2, [context: GoldenWeb.MarkerView, import: Marker.HTML],
                [
                  [class: "h2"],
                  {{:., [], [{{:., [], [assigns, :conn]}, [no_parens: true], []}, :host]},
                   [no_parens: true], []}
                ]}
             ]
           ]}
        ]},
       {{:., [], [{:__aliases__, [alias: false], [:Marker, :Compiler]}, :expand]}, [],
        [
          {:var!, [context: GoldenWeb.MarkerView, import: Kernel],
           [{:html, [context: GoldenWeb.MarkerView, import: Marker.HTML], GoldenWeb.MarkerView}]},
          {:__ENV__, [], GoldenWeb.MarkerView}
        ]}
     ]}
  end

  def index(assigns) do
    (
      Marker.HTML

      (
        Kernel
        Marker.HTML
      )
    )

    _ = assigns

    :erlang.element(
      1,
      Code.eval_quoted(
        (
          greeting =
            (
              msgid = "Welcome to %{name}"
              Gettext.dpgettext(GoldenWeb.Gettext, "default", nil, msgid, name: "Phoenix!")
            )

          {:safe,
           Marker.Compiler.concat(
             :lists.reverse([
               "</div>"
               | (
                   expr =
                     Marker.Encoder.encode(
                       Marker.Compiler.concat(
                         :lists.reverse([
                           "</div>"
                           | (
                               expr =
                                 Marker.Encoder.encode(
                                   Marker.Compiler.concat(
                                     :lists.reverse([
                                       "</div>"
                                       | (
                                           expr =
                                             Marker.Encoder.encode(
                                               Element.column__template(%{
                                                 __content__:
                                                   List.wrap([
                                                     Element.Input.text(
                                                       id: "above",
                                                       attrs: [id: "aj"],
                                                       label: Element.Input.label_above("Above")
                                                     ),
                                                     Element.Input.text(
                                                       id: "below",
                                                       attrs: [],
                                                       label: Element.Input.label_below("Below")
                                                     ),
                                                     Element.Input.text(
                                                       id: "left",
                                                       attrs: [],
                                                       label: Element.Input.label_left("Left")
                                                     ),
                                                     Element.Input.text(
                                                       id: "right",
                                                       attrs: [],
                                                       label: Element.Input.label_right("Right")
                                                     )
                                                   ]),
                                                 spacing: 4,
                                                 id: "av",
                                                 class: "mango"
                                               })
                                             )

                                           [expr | [">" | ["<div" | []]]]
                                         )
                                     ])
                                   )
                                 )

                               [expr | [">" | [" style='padding: 10px'" | ["<div" | []]]]]
                             )
                         ])
                       )
                     )

                   [
                     expr
                     | (
                         expr =
                           Marker.Encoder.encode(
                             Marker.Compiler.concat(
                               :lists.reverse([
                                 "</h2>"
                                 | (
                                     expr =
                                       Marker.Encoder.encode(
                                         Marker.fetch_assign!(assigns, :conn).host
                                       )

                                     [expr | [">" | [" class='h2'" | ["<h2" | []]]]]
                                   )
                               ])
                             )
                           )

                         [
                           expr
                           | (
                               expr =
                                 Marker.Encoder.encode(
                                   Marker.Compiler.concat(
                                     :lists.reverse([
                                       "</h2>"
                                       | (
                                           expr = Marker.Encoder.encode(greeting)
                                           [expr | [">" | [" class='h2'" | ["<h2" | []]]]]
                                         )
                                     ])
                                   )
                                 )

                               [
                                 expr
                                 | [
                                     ">"
                                     | [
                                         " style='background: #fafafa'"
                                         | [" class='p-4'" | ["<div" | []]]
                                       ]
                                   ]
                               ]
                             )
                         ]
                       )
                   ]
                 )
             ])
           )}
        ),
        []
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