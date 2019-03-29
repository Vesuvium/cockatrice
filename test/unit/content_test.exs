defmodule CockatriceTest.Content do
  use ExUnit.Case
  import Dummy
  alias Cockatrice.Content
  alias Cockatrice.Frontmatter

  test "extracting frontmatter and markdown from a string" do
    dummy String, [{"split", fn _a, _b, _c -> ["front", "markdown"] end}] do
      assert Content.extract("string") == ["front", "markdown"]
      assert called(String.split("string", ~r/\n-{3,}\n/, parts: 2))
    end
  end

  test "read a markdown file with frontmatter" do
    dummy File, ["read!"] do
      dummy String, [{"split", fn _a, _b, _c -> ["front", "markdown"] end}] do
        dummy Earmark, ["as_html!"] do
          dummy Frontmatter, [
            {"parse", fn _a -> %{"key" => "value"} end},
            {"defaults", fn _a, _b -> "defaults" end}
          ] do
            result = Content.read("path")
            assert called(String.split("path", ~r/\n-{3,}\n/, parts: 2))
            assert called(Earmark.as_html!("markdown"))
            assert called(Frontmatter.parse("front"))

            assert called(
                     Frontmatter.defaults(%{"content" => "markdown", "key" => "value"},
                       layout: "page.pug"
                     )
                   )

            assert result == "defaults"
          end
        end
      end
    end
  end
end
