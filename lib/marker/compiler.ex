defmodule Marker.Compiler do
  @moduledoc """
  `Marker.Compiler` renders the element macros to html. It tries do as much work during macro expansion,
  resulting in a run time performance comparible to precompiled templates.
  
  For example, this element call:
  
  ```elixir
  div 1 + 1
  ```
  
  will be expanded to this:
  
  ```elixir
  "<div>" <> Marker.Encoder.encode(1 + 1) <> "</div>"
  ```
  """

  alias Marker.Element

  @type element :: String.t() | Macro.t() | Marker.Element.t()
  @type chunks :: [String.t() | Macro.t()]

  # API

  @doc false
  # @spec compile_env(Marker.content(), any) :: {:safe, String.t()} | Macro.t()
  def compile_env(content, env) do
    content
    |> compile([])
    |> to_result()
    |> case do
      {:safe, body} ->
        if :ok == Macro.validate(body) do
          body
          |> expand(env)
        else
          {:safe, body}
        end

      macro ->
        macro
    end
  end

  @doc false
  @spec escape(String.t()) :: String.t()
  def escape(string) do
    escape(string, "")
  end

  # Content parsing

  @spec compile(Marker.content(), chunks) :: chunks
  defp compile(content, chunks) when is_list(content) do
    Enum.reduce(content, chunks, &compile/2)
  end

  @spec compile(element, chunks) :: chunks
  defp compile(%Element{tag: tag, attrs: attrs, content: content}, chunks) do
    chunks =
      chunks
      |> maybe_doctype(tag)
      |> begin_tag_open(tag)
      |> build_attrs(attrs)

    if void_element?(tag) do
      void_tag_close(chunks)
    else
      compile(content, begin_tag_close(chunks))
      |> end_tag(tag)
    end
  end

  defp compile(value, chunks) do
    add_chunk(chunks, Marker.Encoder.encode(value))
  end

  # Element helpers

  defp begin_tag_open(chunks, tag), do: add_chunk(chunks, "<#{tag}")
  defp begin_tag_close(chunks), do: add_chunk(chunks, ">")
  defp void_tag_close(chunks), do: add_chunk(chunks, "/>")

  defp end_tag(chunks, tag), do: add_chunk(chunks, "</#{tag}>")

  defp maybe_doctype(chunks, :html), do: add_chunk(chunks, "<!doctype html>\n")
  defp maybe_doctype(chunks, _), do: chunks

  defp void_element?(tag) do
    tag in ~w(area base br col embed hr img input keygen link meta param source track wbr)a
  end

  # Attributes parsing

  @spec build_attrs(chunks, Marker.Element.attrs()) :: chunks
  defp build_attrs(chunks, attrs) when is_list(attrs) do
    Enum.reduce(attrs, chunks, fn
      {_, nil}, chunks -> chunks
      {_, false}, chunks -> chunks
      {k, true}, chunks -> enabled_attr(chunks, k)
      {k, v}, chunks -> attr(chunks, k, v)
    end)
  end

  defp build_attrs(chunks, attrs) do
    if Macro.validate(attrs) do
      quote do
        Enum.reduce(unquote(attrs), unquote(chunks), fn
          {_, nil}, chunks -> chunks
          {_, false}, chunks -> chunks
          {k, true}, chunks -> Marker.Compiler.enabled_attr(chunks, k)
          {k, v}, chunks -> Marker.Compiler.attr(chunks, k, v)
        end)
      end
    else
      chunks
    end
  end

  @spec attr(chunks, atom, Marker.Encoder.t()) :: chunks
  def attr(chunks, field, value) do
    field = attr_field(field)

    case Marker.Encoder.encode(value) do
      string when is_binary(string) ->
        add_chunk(chunks, "#{field}='#{string}'")

      expr ->
        add_chunk(chunks, attr_resolver(field, expr))
    end
  end

  @spec enabled_attr(chunks, atom) :: chunks
  def enabled_attr(chunks, field) do
    add_chunk(chunks, attr_field(field))
  end

  defp attr_field(field) do
    case Atom.to_string(field) do
      "_" <> field -> " data-" <> field
      field -> " " <> field
    end
  end

  # Helpers

  entity_map = %{
    "&" => "&amp;",
    "<" => "&lt;",
    ">" => "&gt;",
    "\"" => "&quot;",
    "'" => "&#39;"
  }

  for {char, entity} <- entity_map do
    defp escape(unquote(char) <> rest, acc) do
      escape(rest, unquote(entity) <> acc)
    end
  end

  defp escape(<<char::utf8, rest::binary>>, acc) do
    escape(rest, acc <> <<char::utf8>>)
  end

  defp escape("", acc) do
    acc
  end

  defp add_chunk([acc | rest], chunk) when is_binary(acc) and is_binary(chunk) do
    rest ++ [acc <> chunk]
  end

  defp add_chunk(chunks, chunk) when is_binary(chunk) do
    if :ok == Macro.validate(chunks) do
      quote do
        unquote(chunks) ++ [unquote(chunk)]
      end
    else
      chunks ++ [chunk]
    end
  end

  defp add_chunk(chunks, {:safe, expr}) do
    if :ok == Macro.validate(chunks) do
      quote do
        unquote(chunks) ++ [expr]
      end
    else
      chunks ++ [expr]
    end
  end

  defp add_chunk(chunks, chunk) do
    if :ok == Macro.validate(chunks) do
      quote do
        expr = Marker.Encoder.encode(unquote(chunk))
        unquote(chunks) ++ [expr]
      end
    else
      expr = quote do: Marker.Encoder.encode(unquote(chunk))
      chunks ++ [expr]
    end
  end

  defp to_result([string]) when is_binary(string) do
    {:safe, string}
  end

  defp to_result(chunks) do
    if Macro.validate(chunks) == :ok do
      {:safe, quote(do: {:safe, Marker.Compiler.concat(unquote(chunks))})}
    else
      {:safe, concat(chunks)}
    end
  end

  def concat(buffer) do
    Enum.reduce(buffer, fn chunk, acc ->
      quote do
        unquote(acc) <> unquote(chunk)
      end
    end)
  end

  # defmacro concat(buffer) do
  #   Enum.reduce(buffer, fn chunk, acc ->
  #     quote do
  #       unquote(acc) <> unquote(chunk)
  #     end
  #   end)
  # end

  # defp to_result(chunks) do
  #   if Macro.validate(chunks) == :ok do
  #     {:safe,
  #      quote do
  #        {:safe,
  #         Enum.reduce(unquote(chunks), fn chunk, acc ->
  #           # unquote_splicing()
  #           unquote(acc) <> unquote(chunk)
  #         end)}
  #      end}
  #   else
  #     {:safe, concat(chunks)}
  #   end
  # end
  def expand(arg, env) do
    Macro.prewalk(arg, &Macro.expand_once(&1, env))
  end

  defp attr_resolver(field, expr) do
    {:safe,
     quote do
       case unquote(expr) do
         nil -> ""
         false -> ""
         true -> unquote(field)
         value -> unquote(field) <> "='" <> Marker.Encoder.encode(value) <> "'"
       end
     end}
  end
end
