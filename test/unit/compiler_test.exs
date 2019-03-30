defmodule CockatriceTest.Compiler do
  use ExUnit.Case
  import Dummy
  alias Cockatrice.Compiler
  alias Cockatrice.FindFiles
  alias Cockatrice.Page

  test "the Compiler.compile function" do
    dummy FindFiles, [{"search", fn _a, _b -> ["page.md"] end}] do
      dummy Page, [{"new", "content"}, "write/2"] do
        Compiler.compile()
        assert called(FindFiles.search("content", ".md"))
        assert called(Page.new("page.md"))
        assert called(Page.write("content", "testdist", "page.md"))
      end
    end
  end
end
