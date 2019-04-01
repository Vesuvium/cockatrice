defmodule Medusa.Project.Skeletons do
  def page_template do
    """
    doctype html
    html
        head
            meta(charset="utf-8")
            meta(name="viewport", content="width=device-width, initial-scale=1")
        body
            h1 Welcome to Medusa!
    """
  end

  def content_index(name) do
    """
    ---
    title: #{name}'s Home
    ---
    Hello, world!
    """
  end
end
