defmodule ElixirMunich.RootLayout do
  @moduledoc """
  The HTML document skeleton shared by every page: `<head>`, meta tags and
  stylesheet. Page content is rendered through `ElixirMunich.AppLayout`.
  """
  use Tableau.Layout
  use Phoenix.Component

  alias Phoenix.HTML

  def template(assigns) do
    assigns =
      Map.merge(assigns, %{
        title: page_title(assigns.page),
        description: assigns.page[:description] || ElixirMunich.description(),
        page_url: ElixirMunich.url(assigns.page.permalink),
        og_image: ElixirMunich.url("/images/og-image.png")
      })

    ~H"""
    <!DOCTYPE html>
    <html lang="en" data-theme="dark">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>{@title}</title>
        <meta name="description" content={@description} />
        <meta property="og:title" content={@title} />
        <meta property="og:description" content={@description} />
        <meta property="og:type" content="website" />
        <meta property="og:url" content={@page_url} />
        <meta property="og:site_name" content={ElixirMunich.name()} />
        <meta property="og:image" content={@og_image} />
        <meta property="og:image:type" content="image/png" />
        <meta property="og:image:width" content="1200" />
        <meta property="og:image:height" content="630" />
        <meta property="og:image:alt" content={ElixirMunich.name()} />
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:title" content={@title} />
        <meta name="twitter:description" content={@description} />
        <meta name="twitter:image" content={@og_image} />
        <meta name="twitter:image:alt" content={ElixirMunich.name()} />
        <link rel="icon" href="/images/elixir-munich-logo.svg" type="image/svg+xml" />
        <link rel="stylesheet" href="/css/app.css" />
      </head>
      <body>
        {render(@inner_content)}
        {live_reload(assigns)}
      </body>
    </html>
    """
    |> HTML.Safe.to_iodata()
  end

  defp page_title(%{title: title}) when is_binary(title), do: "#{title} · #{ElixirMunich.name()}"
  defp page_title(_page), do: ElixirMunich.name()

  if Code.ensure_loaded?(TableauDevServer) do
    defp live_reload(assigns), do: HTML.raw(TableauDevServer.live_reload(assigns))
  else
    defp live_reload(_assigns), do: nil
  end
end
