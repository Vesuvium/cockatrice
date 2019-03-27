defmodule CockatriceTest.Page do
  use ExUnit.Case
  import Dummy
  alias Cockatrice.Page
  test "the write function" do
    dummy File, [{"write", fn _a, _b -> nil end}] do
      Page.write("page", "dist")
      assert called(File.write("dist/index.html", "page"))
    end
  end
end
