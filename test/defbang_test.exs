defmodule Foo do
  import Defbang

  defbang is_positive(number) do
    if number > 0 do
      {:ok, "This is a positive number"}
    else
      {:error, %RuntimeError{message: "This is not a positive number"}}
    end
  end

  defunbang is_negative(number) do
    if number < 0 do
      "This is a negative number"
    else
      raise %RuntimeError{message: "This is not a negative number"}
    end
  end
end

defmodule DefbangTest do
  use ExUnit.Case
  doctest Defbang

  test "has bang and unbanged functions" do
    functions = Foo.__info__(:functions)
    assert Keyword.has_key?(functions, :is_positive)
    assert Keyword.has_key?(functions, :is_positive!)

    assert Keyword.has_key?(functions, :is_negative)
    assert Keyword.has_key?(functions, :is_negative!)
  end

  test "bang and unbanged functions behave as expected" do
    assert {:ok, _} = Foo.is_positive(1)
    assert {:error, _} = Foo.is_positive(-1)

    assert {:ok, _} = Foo.is_negative(-1)
    assert {:error, _} = Foo.is_negative(1)

    assert _ = Foo.is_positive!(1)
    assert_raise RuntimeError, fn -> Foo.is_positive!(-1) end

    assert _ = Foo.is_negative!(-1)
    assert_raise RuntimeError, fn -> Foo.is_negative(-1) end
  end
end
