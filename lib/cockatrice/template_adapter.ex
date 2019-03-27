defmodule Cockatrice.TemplateAdapter do
  @callback compile(any, String.t()) :: String.t()
end
