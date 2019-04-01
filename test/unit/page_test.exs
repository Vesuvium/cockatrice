defmodule MedusaTest.Page do
  use ExUnit.Case
  import Dummy

  alias Medusa.Adapters.Pug
  alias Medusa.Content
  alias Medusa.Files
  alias Medusa.Page

  test "the new function" do
    content = %{layout: "page.pug"}

    dummy Confex, [{"get_env", fn _a, _b -> "templates" end}] do
      dummy Content, [{"read", content}] do
        dummy Pug, ["compile/2"] do
          Page.new("file")
          assert called(Confex.get_env(:medusa, :templates))
          assert called(Content.read("file"))
          assert called(Pug.compile(content, "templates/page.pug"))
        end
      end
    end
  end

  test "the target function" do
    assert Page.target("content/page.md", "dist") == "dist/page.html"
  end

  test "the target function with a nested path" do
    assert Page.target("content/blog/page.md", "dist") == "dist/blog/page.html"
  end

  test "the write function" do
    dummy Files, ["write/2"] do
      dummy Page, [{"target", fn _a, _b -> "target" end}] do
        Page.write("content", "dist", "page.md")
        assert called(Medusa.Page.target("page.md", "dist"))
        assert called(Files.write("target", "content"))
      end
    end
  end
end
