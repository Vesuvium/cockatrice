defmodule CockatriceTest.Page do
  use ExUnit.Case
  import Dummy
  alias Cockatrice.Page
  alias Cockatrice.Markdown
  alias Cockatrice.Adapters.Pug

  test "the new function" do
    dummy Confex, [{"get_env", fn _a, _b -> "templates" end}] do
      dummy Markdown, ["read"] do
        dummy Pug, [{"compile", fn _a, _b -> nil end}] do
          Page.new("file")
          assert called(Confex.get_env(:cockatrice, :templates))
          assert called(Markdown.read("file"))
          assert called(Pug.compile("file", "templates/layout.pug"))
        end
      end
    end
  end

  test "the write function" do
    dummy File, [{"write", fn _a, _b -> nil end}] do
      Page.write("page", "dist")
      assert called(File.write("dist/index.html", "page"))
    end
  end
end
