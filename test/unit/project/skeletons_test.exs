defmodule MedusaTest.Project.Skeletons do
  use ExUnit.Case
  alias Medusa.Project.Skeletons

  test "the content/index.md skeleton" do
    # check because of interpolation
    assert is_binary(Skeletons.content_index("jacopo"))
  end

  test "the templates/page.pug skeleton" do
    assert is_binary(Skeletons.page_template())
  end
end
