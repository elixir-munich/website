import Config

config :tableau, :config,
  url: "http://localhost:4999",
  include_dir: "extra",
  out_dir: "_site"

config :tableau, :reloader,
  patterns: [
    ~r"^lib/.*.ex",
    ~r"^assets/.*.(css|js)",
    ~r"^extra/.*"
  ]

config :tableau, :assets, tailwind: {Tailwind, :install_and_run, [:elixir_munich, ~w(--watch)]}

# The site has no Markdown pages or posts.
config :tableau, Tableau.PageExtension, enabled: false
config :tableau, Tableau.PostExtension, enabled: false

config :tailwind,
  version: "4.3.5",
  elixir_munich: [
    args: ~w(
      --input=assets/css/app.css
      --output=_site/css/app.css
    ),
    cd: Path.expand("..", __DIR__)
  ]

import_config "#{config_env()}.exs"
