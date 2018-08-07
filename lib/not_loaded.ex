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

  @type field_name :: atom

  @type t :: %__MODULE__{
          __field__: field_name
        }

  defimpl Inspect do
    def inspect(not_loaded, _opts) do
      msg = "field #{inspect(not_loaded.__field__)} is not loaded"
      "##{inspect(@for)}<#{msg}>"
    end
  end

  @doc """
  Creates a new `NotLoaded` struct for a given field name.
  """
  @spec new(field_name) :: t
  def new(field_name) do
    %__MODULE__{__field__: field_name}
  end

  @doc """
  Defaults a struct field to `NotLoaded`.
  """
  defmacro lazy_loaded(field_name) when is_atom(field_name) do
    quote do
      {unquote(field_name), unquote(__MODULE__).new(unquote(field_name))}
    end
  end
end
