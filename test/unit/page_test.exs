defmodule CockatriceTest.Page do
  use ExUnit.Case
  import Dummy
  alias Cockatrice.Page
  alias Cockatrice.Content
  alias Cockatrice.Adapters.Pug

  test "the new function" do
    content = %{layout: "page.pug"}

    dummy Confex, [{"get_env", fn _a, _b -> "templates" end}] do
      dummy Content, [{"read", content}] do
        dummy Pug, ["compile/2"] do
          Page.new("file")
          assert called(Confex.get_env(:cockatrice, :templates))
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

  test "preparing a simple path" do
    dummy File, ["mkdir_p!"] do
      assert Page.prepare_path("dist/page.html") == "dist/page.html"
      assert called(File.mkdir_p!("dist"))
    end
  end

  test "preparing a nested path" do
    dummy File, ["mkdir_p!"] do
      Page.prepare_path("dist/nested/page.md")
      assert called(File.mkdir_p!("dist/nested"))
    end
  end

  test "the write function" do
    dummy File, ["write/2", "mkdir_p!"] do
      dummy Page, [{"target", fn _a, _b -> "target" end}] do
        Page.write("content", "dist", "page.md")
        assert called(Cockatrice.Page.target("page.md", "dist"))
        assert called(File.write("target", "content"))
      end
    end
  end
end
