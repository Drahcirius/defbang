defmodule Defbang.MixProject do
  use Mix.Project

  def project do
    [
      app: :defbang,
      version: "0.1.0",
      elixir: "~> 1.8",
      description: "Macros to define a banged and its unbanged version."
    ]
  end
end
