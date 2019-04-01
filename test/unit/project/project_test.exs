defmodule MedusaTest.Project do
  use ExUnit.Case
  import Dummy

  alias Medusa.Files
  alias Medusa.Project
  alias Medusa.Project.Skeletons

  test "initializing templates" do
    dummy Files, ["write/2"] do
      dummy Skeletons, [{"page_template", fn -> "page" end}] do
        Project.init_templates("name")
        assert called(Skeletons.page_template())
        assert called(Files.write("name/templates/page.pug", "page"))
      end
    end
  end

  test "initializing content" do
    dummy Files, ["write/2"] do
      dummy Skeletons, ["content_index"] do
        Project.init_content("name")
        assert called(Skeletons.content_index("name"))
        assert called(Files.write("name/content/index.md", "name"))
      end
    end
  end

  test "creating a new project" do
    dummy Project, ["init_templates", "init_content"] do
      Project.new("name")
      assert called(Project.init_templates("name"))
      assert called(Project.init_content("name"))
    end
  end
end
