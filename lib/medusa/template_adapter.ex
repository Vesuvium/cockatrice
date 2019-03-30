defmodule Medusa.TemplateAdapter do
  @callback compile(any, String.t()) :: String.t()
end
