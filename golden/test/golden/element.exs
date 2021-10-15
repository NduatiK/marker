defmodule Golden.ElementTest do
  use ExUnit.Case, async: true
  require ElmView
  import ElmView
  alias ElmView.Text

  describe "text" do
    test "renders all it's formats" do
      assert text("abc") == %Text{content: "abc"}
      assert text(:abc) |> render() =~ "@abc"

      from_func =
        text({:abc, &String.upcase/1})
        |> render()

      assert from_func =~ "@abc"
      assert from_func =~ "&String.upcase/1"

      from_list =
        text([
          {:func, &String.upcase/1},
          "str",
          :atom
        ])
        |> render()

      assert from_list =~ "str"
      assert from_list =~ "@func"
      assert from_list =~ "&String.upcase/1"
      assert from_list =~ "@atom"
    end

    test "escapes special chars without destroying the rest of the string" do
      assert text("abc & def") == %Text{content: "abc &amp; def"}
      assert text("abc < def") == %Text{content: "abc &lt; def"}
      assert text("abc > def") == %Text{content: "abc &gt; def"}
      assert text("abc \" def") == %Text{content: "abc &quot; def"}
    end
  end

  describe "column" do
    test "renders all its children" do
      tree =
        column([], [
          text("Hi"),
          text("World")
        ])
        |> ElmView.Renderer.render()

      assert tree =~ "Hi"
      assert tree =~ "World"
    end
  end
end
