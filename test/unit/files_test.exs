defmodule MedusaTest.Files do
  use ExUnit.Case
  import Dummy
  alias Medusa.Files

  test "reading a path" do
    ls = fn path ->
      if(path == "dir", do: {:ok, ["content.md"]}, else: {:error, nil})
    end

    dummy File, [{"ls", ls}] do
      assert Files.search("dir", ".md") == ["dir/content.md"]
    end
  end

  test "discarding non-needed extensions" do
    ls = fn path ->
      if(path == "dir", do: {:ok, ["content.js"]}, else: {:error, nil})
    end

    dummy File, [{"ls", ls}] do
      assert Files.search("dir", ".md") == []
    end
  end
end
