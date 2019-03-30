defmodule MedusaTest.Frontmatter do
  use ExUnit.Case
  import Dummy

  alias Medusa.Frontmatter
  alias Medusa.Yaml

  test "parsing the frontmatter" do
    dummy Yaml, [{"read", %{"key" => "value"}}] do
      assert Frontmatter.parse("string") == %{"key" => "value"}
      assert called(Yaml.read("string"))
    end
  end

  test "setting defaults values" do
    result = Frontmatter.defaults(%{}, layout: "page.pug")
    assert result == %{:layout => "page.pug"}
  end

  test "allowing defaults to be overwritten" do
    frontmatter = %{:layout => "index.pug"}
    result = Frontmatter.defaults(frontmatter, layout: "page.pug")
    assert result == frontmatter
  end
end
