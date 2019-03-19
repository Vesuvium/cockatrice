defmodule CockatriceTest.Yaml do
  use ExUnit.Case
  import Dummy
  alias Cockatrice.Yaml

  test "reading yaml files successfully" do
    read = fn string ->
      {:ok, string}
    end

    dummy YamlElixir, [{"read_from_string", read}] do
      assert Yaml.read("string") == "string"
      called(YamlElixir.read_from_string("string"))
    end
  end

  test "reading yaml files unsuccessfully" do
    read = fn string ->
      {:error, "err"}
    end

    dummy YamlElixir, [{"read_from_string", read}] do
      assert Yaml.read("string") == nil
    end
  end
end
