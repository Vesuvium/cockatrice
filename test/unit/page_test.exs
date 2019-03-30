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

  test "the write function" do
    dummy File, ["write/2"] do
      Page.write("page", "dist")
      assert called(File.write("dist/index.html", "page"))
    end
  end
end
