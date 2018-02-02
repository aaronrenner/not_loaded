defmodule NotLoaded do
  @moduledoc """
  Struct returned by fields when they have not been loaded.

  ## Example

      defmodule Book do
         import NotLoaded, only: [lazy_loaded: 1]

        defstruct [
           :title,
            lazy_loaded(:author)
         ]
       end
  """
  defstruct [:__field__]

  @opaque t :: %__MODULE__{
    __field__: atom
  }

  defimpl Inspect do
    def inspect(not_loaded, _opts) do
      msg = "field #{inspect not_loaded.__field__} is not loaded"
      "##{inspect @for}<#{msg}>"
    end
  end

  @doc """
  Defaults a struct field to `NotLoaded`.
  """
  defmacro lazy_loaded(field_name) when is_atom(field_name) do
    quote do
      {unquote(field_name),
       %unquote(__MODULE__){__field__: unquote(field_name)}}
    end
  end
end
