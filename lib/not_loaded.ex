defmodule NotLoaded do
  @moduledoc """
  Struct returned by fields when they have not been loaded.

  ## Example

      # Define your NotLoaded module
      NotLoaded.defmodule(MyApp.NotLoaded)

      # Use this module in your application
      defmodule MyApp.Book do
         import MyApp.NotLoaded, only: [lazy_loaded: 1]

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
  @deprecated "Use defmodule/1 to define an application specific NotLoaded module, instead"
  @spec new(field_name) :: t
  def new(field_name) do
    %__MODULE__{__field__: field_name}
  end

  @doc """
  Defaults a struct field to `NotLoaded`.
  """
  @deprecated "Use `defmodule/1` to define an application specific NotLoaded module, instead"
  defmacro lazy_loaded(field_name) when is_atom(field_name) do
    quote do
      {unquote(field_name), unquote(__MODULE__).new(unquote(field_name))}
    end
  end

  @doc """
  Generate a NotLoaded module
  """
  def defmodule(name) when is_atom(name) do
    contents =
      quote do
        @moduledoc """
        Struct returned for fields when they are not loaded.

        The fields are:
        * `__field__` - the field on `__owner__` struct that is not loaded
        * `__owner__` - the module of the struct that defined this field
        """
        defstruct [:__field__, :__owner__]

        @type field_name :: atom

        @type t :: %__MODULE__{
                __field__: field_name,
                __owner__: module
              }

        defimpl Inspect do
          def inspect(not_loaded, _opts) do
            msg = "field #{inspect(not_loaded.__field__)} is not loaded"
            "##{inspect(@for)}<#{msg}>"
          end
        end

        @doc """
        Defaults a struct field to `#{inspect(__MODULE__)}`.

        Automatically populates `__field__` and `__owner__`.

        ## Example

            defmodule MyStruct do
              import #{inspect(__MODULE__)}, only: [lazy_loaded: 1]

              defstruct [
                :title,
                lazy_loaded(:author)
              ]
            end
        """
        defmacro lazy_loaded(field_name) when is_atom(field_name) do
          quote do
            {unquote(field_name),
             %unquote(__MODULE__){__field__: unquote(field_name), __owner__: __MODULE__}}
          end
        end
      end

    Module.create(name, contents, Macro.Env.location(__ENV__))
  end
end
