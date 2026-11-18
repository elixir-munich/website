# Elixir, Erlang & Gleam Munich Website

The official [website](https://elixir-munich.org) for the Elixir, Erlang & Gleam Munich community, serving as our central hub.

It's a static site built with [Tableau](https://hexdocs.pm/tableau) (Elixir), using HEEx templates and Tailwind CSS, and hosted on GitHub Pages.

## Getting Started

> We recommend using [Jujutsu](https://jj-vcs.github.io/jj/latest/) instead of Git for a better development experience.

```sh
jj git clone https://github.com/elixir-munich/website.git
cd website

mix setup

mix tableau.server
```

Visit [`localhost:4999`](http://localhost:4999) to see the site. Pages rebuild on request, Tailwind recompiles on change, and the browser reloads automatically when you edit files in `lib/`, `assets/` or `extra/`.

## Project layout

| Path | What it is |
| --- | --- |
| `lib/elixir_munich/pages/` | One module per page (`use Tableau.Page`, with a `permalink`) |
| `lib/elixir_munich/layouts/` | `RootLayout` (`<head>`, meta tags) wraps `AppLayout` (background, header) |
| `lib/elixir_munich/components.ex` | Shared function components and the navigation links |
| `assets/css/app.css` | Tailwind v4 entry point (plus the daisyUI and heroicons plugins) |
| `extra/` | Copied as-is into the site root (images, `favicon.ico`, `robots.txt`) |
| `_site/` | Build output (git-ignored) |

## Building

```sh
MIX_ENV=prod mix build   # writes the static site to _site/
mix precommit            # compile (warnings as errors), format, credo, tests
```

`MIX_ENV=prod` makes the canonical/Open Graph URLs point at `https://elixir-munich.org`.

## Deployment

The **Build & Deploy** workflow builds and tests every push and pull request. Every push to `main` (including merged pull requests) is deployed to GitHub Pages. To redeploy without a new commit, run the workflow by hand (Actions → Build & Deploy → Run workflow).

---

Built with ❤️ by the Elixir, Erlang & Gleam Munich community
