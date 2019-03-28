defmodule CockatriceTest.Compiler do
  use ExUnit.Case
  import Dummy
  alias Cockatrice.Compiler
  alias Cockatrice.FindFiles
  alias Cockatrice.Page

  test "the Compiler.compile function" do
    dummy FindFiles, [{"search", fn _a, _b -> ["text"] end}] do
      dummy Page, ["new", {"write", fn _a, _b -> nil end}] do
        Compiler.compile()
        assert called(FindFiles.search("content", ".md"))
        assert called(Page.new("text"))
        assert called(Page.write("text", "testdist"))
      end
    end
  end
end
