defmodule MedusaTest.Adapters.Pug do
  use ExUnit.Case
  import Dummy
  alias Medusa.Adapters.Pug

  test "the raw function" do
    assert Pug.raw("string") == "string"
  end

  test "the compile function" do
    dummy File, ["read!"] do
      dummy Expug, [{"to_eex!", fn a, _b -> a end}] do
        dummy EEx, [{"eval_string", fn a, _b -> a end}] do
          assert Pug.compile("data", "path") == "path"
          assert called(File.read!("path"))
          assert called(Expug.to_eex!("path", raw_helper: "Medusa.Pug.raw"))
          assert called(EEx.eval_string("path", assigns: [page: "data"]))
        end
      end
    end
  end
end
