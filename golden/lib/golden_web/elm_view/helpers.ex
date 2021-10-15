defmodule ElmView.Helpers do
  entity_map = %{
    "&" => "&amp;",
    "<" => "&lt;",
    ">" => "&gt;",
    "\"" => "&quot;"
    # "'" => "&#39;"
  }

  for {char, entity} <- entity_map do
    defp escape(unquote(char) <> rest, acc) do
      escape(rest, acc <> unquote(entity))
    end
  end

  defp escape(<<char::utf8, rest::binary>>, acc) do
    escape(rest, acc <> <<char::utf8>>)
  end

  defp escape("", acc) do
    acc
  end

  def escape(str) when is_binary(str), do: escape(str, "")
  def escape(not_str), do: not_str
end
