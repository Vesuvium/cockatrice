defmodule CockatriceTest.Yaml do
  use ExUnit.Case
  import Dummy
  alias Cockatrice.Yaml

  test "reading yaml files successfully" do
    dummy YamlElixir, [{"read_from_string", {:ok, string}}] do
      assert Yaml.read("string") == "string"
      called(YamlElixir.read_from_string("string"))
    end
  end

  test "reading yaml files unsuccessfully" do
    dummy YamlElixir, [{"read_from_string", {:error, "err"}}] do
      assert Yaml.read("string") == nil
    end
  end
end
