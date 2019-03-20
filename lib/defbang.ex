defmodule Defbang do
  defmacro defbang({name, metadata, args} = call, body) do
    banged_name = String.to_atom(Atom.to_string(name) <> "!")
    banged_call = {banged_name, metadata, args}

    quote do
      def unquote(call), unquote(body)

      def unquote(banged_call) do
        [do: expr] = unquote(body)

        case expr do
          {:ok, result} -> result
          {:error, err} -> raise err
        end
      end
    end
  end

  defmacro defbang(err_type, {name, metadata, args} = call, body) do
    banged_name = String.to_atom(Atom.to_string(name) <> "!")
    banged_call = {banged_name, metadata, args}

    quote do
      def unquote(call), unquote(body)

      def unquote(banged_call) do
        [do: expr] = unquote(body)

        case expr do
          {:ok, result} -> result
          {:error, err} -> raise unquote(err_type), err
        end
      end
    end
  end

  defmacro defunbang({name, metadata, args} = call, body) do
    banged_name = String.to_atom(Atom.to_string(name) <> "!")
    banged_call = {banged_name, metadata, args}

    quote do
      def unquote(call) do
        try do
          [do: expr] = unquote(body)
          {:ok, expr}
        rescue
          err -> {:error, err}
        end
      end

      def unquote(banged_call), unquote(body)
    end
  end
end
