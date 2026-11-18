defmodule ElixirMunich.SiteBuildTest do
  use ExUnit.Case, async: false

  alias Mix.Tasks.Tableau.Build

  setup_all do
    out = Path.join(System.tmp_dir!(), "elixir_munich_site_#{System.unique_integer([:positive])}")
    on_exit(fn -> File.rm_rf!(out) end)

    Build.run(["--out", out])

    %{out: out}
  end

  defp parse(out, file) do
    out |> Path.join(file) |> File.read!() |> LazyHTML.from_document()
  end

  defp attr(doc, selector, name) do
    doc |> LazyHTML.query(selector) |> LazyHTML.attribute(name) |> List.first()
  end

  describe "index.html" do
    test "renders the landing page inside the app layout", %{out: out} do
      doc = parse(out, "index.html")

      assert doc |> LazyHTML.query("#nav-desktop li") |> Enum.count() == 6
      assert doc |> LazyHTML.query("#nav-mobile li") |> Enum.count() == 6
      assert doc |> LazyHTML.query("h1") |> LazyHTML.text() =~ "Welcome to"
      assert doc |> LazyHTML.query("#bluesky-feed bsky-embed") |> Enum.count() == 1
    end

    test "loads bsky-embed from a pinned version with an SRI hash", %{out: out} do
      doc = parse(out, "index.html")
      src = attr(doc, ~s(script[src*="bsky-embed"]), "src")

      assert src =~ ~r"/bsky-embed@\d+\.\d+\.\d+/"
      assert "sha384-" <> _ = attr(doc, ~s(script[src*="bsky-embed"]), "integrity")
      assert attr(doc, ~s(script[src*="bsky-embed"]), "crossorigin") == "anonymous"
    end

    test "has absolute Open Graph URLs and no Phoenix leftovers", %{out: out} do
      doc = parse(out, "index.html")

      assert attr(doc, ~s(meta[property="og:url"]), "content") == "https://elixir-munich.org/"

      assert attr(doc, ~s(meta[property="og:image"]), "content") ==
               "https://elixir-munich.org/images/og-image.png"

      assert attr(doc, ~s(meta[property="og:image:width"]), "content") == "1200"
      assert attr(doc, ~s(meta[property="og:image:height"]), "content") == "630"

      assert attr(doc, "html", "data-theme") == "dark"
      assert attr(doc, ~s(link[rel="stylesheet"]), "href") == "/css/app.css"
      assert doc |> LazyHTML.query(~s(meta[name="csrf-token"])) |> Enum.empty?()
      assert doc |> LazyHTML.query(~s(script[src*="app.js"])) |> Enum.empty?()
    end
  end

  test "404.html is generated for GitHub Pages", %{out: out} do
    doc = parse(out, "404.html")

    assert doc |> LazyHTML.query("#not-found") |> Enum.count() == 1
    assert doc |> LazyHTML.query("title") |> LazyHTML.text() =~ "Page not found"
  end

  test "static files from extra/ are copied", %{out: out} do
    for file <-
          ~w(favicon.ico robots.txt images/og-image.png images/munich-skyline-bg.jpg images/meetup-logo.svg) do
      assert File.exists?(Path.join(out, file)), "missing #{file}"
    end
  end
end
