defmodule BookmarkOrganizer.HTMLParserTest do
  use BookmarkOrganizer.DataCase

  test "can parse HTML" do
    html = """
    <div>
      <a href="https://example.com">Example</a>
    </div>
    """

    {:ok, document} = Floki.parse_document(html)
    assert Floki.find(document, "a") |> Floki.attribute("href") == ["https://example.com"]
  end
end
