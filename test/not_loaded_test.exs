defmodule NotLoadedTest do
  use ExUnit.Case, async: true

  defmodule Book do
    import NotLoaded, only: [lazy_loaded: 1]

    defstruct [
      :title,
      lazy_loaded(:author)
    ]
  end

  test "inspect" do
    book = %Book{}

    assert "#NotLoaded<field :author is not loaded>" = inspect(book.author)
  end
end
