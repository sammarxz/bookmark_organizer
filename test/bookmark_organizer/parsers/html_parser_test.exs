defmodule BookmarkOrganizer.Parsers.HTMLParser do
  @moduledoc """
  Parser para arquivos HTML de favoritos exportados do navegador.
  Suporta o formato padrão utilizado pelos principais navegadores.
  """

  @doc """
  Parse um arquivo HTML de favoritos e retorna uma lista estruturada.

  ## Exemplos

      iex> html = \"\"\"
      ...> <!DOCTYPE NETSCAPE-Bookmark-file-1>
      ...> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
      ...> <TITLE>Bookmarks</TITLE>
      ...> <H1>Bookmarks</H1>
      ...> <DL><p>
      ...>     <DT><A HREF="https://example.com" ADD_DATE="1698811897">Example Site</A>
      ...>     <DT><H3>My Folder</H3>
      ...>     <DL><p>
      ...>         <DT><A HREF="https://test.com">Test Site</A>
      ...>     </DL><p>
      ...> </DL>
      ...> \"\"\"
      iex> BookmarkOrganizer.Parsers.HTMLParser.parse(html)
      {:ok, [
        %{
          title: "Example Site",
          url: "https://example.com",
          add_date: ~U[2023-11-01 07:51:37Z],
          folder: nil
        },
        %{
          title: "Test Site",
          url: "https://test.com",
          add_date: nil,
          folder: "My Folder"
        }
      ]}
  """
  def parse(html) when is_binary(html) do
    case Floki.parse_document(html) do
      {:ok, document} ->
        case Floki.find(document, "dl") do
          [] -> {:error, :invalid_bookmark_format}
          _ -> {:ok, extract_bookmarks(document)}
        end

      error ->
        error
    end
  end

  defp extract_bookmarks(document) do
    document
    |> Floki.find("dl")
    |> List.first()
    |> parse_node(nil, [])
    |> Enum.reverse()
  end

  defp parse_node({"dl", _, children}, current_folder, acc) do
    parse_children(children, current_folder, acc)
  end

  defp parse_node(_, _current_folder, acc), do: acc

  defp parse_children([], _current_folder, acc), do: acc

  defp parse_children([{"dt", _, children} | rest], current_folder, acc) do
    case children do
      [{"a", attrs, [title]}] ->
        bookmark = %{
          title: title,
          url: get_attr(attrs, "href"),
          add_date: get_attr(attrs, "add_date") |> parse_date(),
          folder: current_folder
        }

        parse_children(rest, current_folder, [bookmark | acc])

      [{"h3", _, [folder_name]}, {"dl", _, folder_children}] ->
        folder_bookmarks = parse_children(folder_children, folder_name, [])
        parse_children(rest, current_folder, folder_bookmarks ++ acc)

      [{"h3", _, [_folder_name]}] ->
        # Pasta vazia, continua processando
        parse_children(rest, current_folder, acc)

      _ ->
        parse_children(rest, current_folder, acc)
    end
  end

  defp parse_children([_ | rest], current_folder, acc) do
    parse_children(rest, current_folder, acc)
  end

  defp get_attr(attrs, name) do
    case List.keyfind(attrs, name, 0) do
      {^name, value} -> value
      nil -> nil
    end
  end

  defp parse_date(nil), do: nil

  defp parse_date(timestamp) do
    case Integer.parse(timestamp) do
      {unix_timestamp, _} ->
        DateTime.from_unix!(unix_timestamp)
        |> DateTime.truncate(:second)

      _ ->
        nil
    end
  end
end
