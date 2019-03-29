defmodule CockatriceTest.Content do
  use ExUnit.Case
  import Dummy
  alias Cockatrice.Yaml
  alias Cockatrice.Content

  test "extracting frontmatter and markdown from a string" do
    dummy String, [{"split", fn _a, _b, _c -> ["front", "markdown"] end}] do
      assert Content.extract("string") == ["front", "markdown"]
      assert called(String.split("string", ~r/\n-{3,}\n/, parts: 2))
    end
  end

  test "transforming frontmatter to a map" do
    dummy Yaml, [{"read", fn _a -> %{"key" => "value"} end}] do
      assert Content.frontmatter("string") == %{"key" => "value"}
      assert called(Yaml.read("string"))
    end
  end

  test "the defaults values" do
    assert Content.defaults(%{}) == %{:layout => "page.pug"}
  end

  test "allowing defaults to be overwritten" do
    frontmatter = %{:layout => "index.pug"}
    assert Content.defaults(frontmatter) == frontmatter
  end

  test "read a markdown file with frontmatter" do
    dummy File, ["read!"] do
      dummy String, [{"split", fn _a, _b, _c -> ["front", "markdown"] end}] do
        dummy Earmark, ["as_html!"] do
          dummy Yaml, [{"read", fn _a -> %{"key" => "value"} end}] do
            result = Content.read("path")
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
