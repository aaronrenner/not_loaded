defmodule NotLoadedTest do
  use ExUnit.Case, async: true

  defmodule Book do
    import NotLoaded, only: [lazy_loaded: 1]

    defstruct [
      :title,
      lazy_loaded(:author)
    ]
  end

  defmodule Employee do
    import NotLoadedTest.CustomNotLoaded, only: [lazy_loaded: 1]

    defstruct [
      :name,
      lazy_loaded(:address)
    ]
  end

  test "inspect" do
    book = %Book{}

    assert "#NotLoaded<field :author is not loaded>" = inspect(book.author)
  end

  test "new/1 creates a new not_loaded struct" do
    assert %NotLoaded{__field__: :password} = NotLoaded.new(:password)
  end

  test "with a custom NotLoaded module" do
    employee = %Employee{}

    not_loaded_struct = employee.address

    assert "#NotLoadedTest.CustomNotLoaded<field :address is not loaded>" =
             inspect(not_loaded_struct)

    assert not_loaded_struct.__owner__ == Employee
    assert not_loaded_struct.__field__ == :address
  end
end
