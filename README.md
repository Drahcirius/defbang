# Defbang

A slightly evil macro that define a function and its banged version. You can write a `bang` function if you want to write using tuples, or `unbang` if you want to raise instead.

**Limitations**
- Debugging with `defbang` is slightly more difficult, as the line which raised the error is not captured. Only the function declaration line is returned. `defunbang` however, will have the correct stack.

## Usage

```elixir
defmodule Foo do
  import Defbang

  defbang is_positive(number) do
    if number > 0 do
      {:ok, "This is a positive number"}
    else
      {:error, %RuntimeError{message: "This is not a positive number"}}
    end
  end

  # or the reverse
  defunbang is_negative(number) do
    if number < 0 do
      "This is a negative number"
    else
      raise %RuntimeError{message: "This is not a negative number"}
    end
  end

end
```

```elixir
iex> Foo.is_positive(1)
{:ok, "This is a positive number"}

iex> Foo.is_positive(-1)
{:error, %RuntimeError{message: "This is not a positive number"}

iex> Foo.check_sign!(0)
"This is a positive number"

iex> Foo.check_sign!(-1)
** (RuntimeError) "This is not a positive number"
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `defbang` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:defbang, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/defbang](https://hexdocs.pm/defbang).

