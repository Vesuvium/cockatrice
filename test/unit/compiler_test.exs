defmodule MedusaTest.Compiler do
  use ExUnit.Case
  import Dummy
  alias Medusa.Compiler
  alias Medusa.Files
  alias Medusa.Page

  test "the Compiler.compile function" do
    dummy Files, [{"search", fn _a, _b -> ["page.md"] end}] do
      dummy Page, [{"new", "content"}, "write/3"] do
        Compiler.compile()
        assert called(Files.search("content", ".md"))
        assert called(Page.new("page.md"))
        assert called(Page.write("content", "testdist", "page.md"))
      end
    end
  end
end
