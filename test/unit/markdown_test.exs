defmodule CockatriceTest.Markdown do
  use ExUnit.Case
  import Dummy
  alias Cockatrice.Yaml
  alias Cockatrice.Markdown

  test "read a markdown file with frontmatter" do
    dummy File, ["read!"] do
      dummy String, [{"split", fn _a, _b, _c -> ["front", "markdown"] end}] do
        dummy Earmark, ["as_html!"] do
          dummy Yaml, [{"read", fn _a -> %{"key" => "value"} end}] do
            result = Markdown.read("path")
            assert called(String.split("path", ~r/\n-{3,}\n/, parts: 2))
            assert called(Earmark.as_html!("markdown"))
            assert called(Yaml.read("front"))
            assert result == %{"content" => "markdown", "key" => "value"}
          end
        end
      end
    end
  end
end
