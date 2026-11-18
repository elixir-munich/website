defmodule ElixirMunich.HomePage do
  @moduledoc "The landing page."
  use Tableau.Page,
    layout: ElixirMunich.AppLayout,
    permalink: "/"

  use Phoenix.Component

  def template(assigns) do
    ~H"""
    <div class="min-h-[calc(100vh-4rem)]">
      <div class="container mx-auto px-4 py-12">
        <div class="text-center mb-16">
          <div class="hero bg-base-100/10 backdrop-blur-md rounded-3xl shadow-xl border border-white/20 p-12">
            <div class="hero-content text-center text-white">
              <div class="max-w-4xl flex flex-col lg:flex-row items-center gap-8">
                <div class="flex-shrink-0">
                  <img
                    src="/images/elixir-munich-logo.svg"
                    alt="Elixir, Erlang & Gleam Munich Logo"
                    class="w-48 h-48 lg:w-48 lg:h-48 rounded-xl mx-auto"
                  />
                </div>
                <div class="flex-1 text-center lg:text-left">
                  <h1 class="text-4xl lg:text-5xl font-bold mb-4">
                    Welcome to Elixir, Erlang & Gleam Munich
                  </h1>
                  <p class="text-lg lg:text-xl opacity-90 leading-relaxed">
                    Join our vibrant community of BEAM enthusiasts in Munich.
                    Connect, learn and share knowledge with fellow developers.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="space-y-6">
          <div class="text-center text-white">
            <h2 class="text-2xl font-bold mb-8">Latest News & Updates</h2>
          </div>

          <div class="max-w-2xl mx-auto">
            <div
              id="bluesky-feed"
              class="card bg-base-100/10 backdrop-blur-md shadow-xl border border-white/20"
            >
              <div class="card-body">
                <div class="card-title text-white mb-4">
                  <img
                    src="/images/bluesky-logo.svg"
                    alt="Bluesky Logo"
                    class="w-6 h-6 mr-2"
                  /> Bluesky Posts
                </div>
                <bsky-embed
                  username="elixir-munich.org"
                  mode="dark"
                  limit="3"
                  load-more="true"
                  disable-images="true"
                  disable-videos="true"
                  disable-autoplay="true"
                >
                </bsky-embed>
              </div>
            </div>
          </div>
        </div>
      </div>

      <footer class="mt-6 py-3 border-t border-white/10">
        <div class="container mx-auto px-4">
          <div class="text-center text-white/40 text-xs leading-tight space-y-1">
            <div>
              Background image from
              <a
                href="https://pxhere.com/en/photo/598927"
                target="_blank"
                rel="noopener noreferrer"
                class="text-purple-300 hover:text-purple-200 underline"
              >
                PxHere
              </a>
              -
              <a
                href="https://creativecommons.org/publicdomain/zero/1.0/"
                target="_blank"
                rel="noopener noreferrer"
                class="text-purple-300 hover:text-purple-200 underline"
              >
                CC0 Public Domain
              </a>
            </div>
            <div>
              Meetup icon made from
              <a
                href="https://www.onlinewebfonts.com/icon"
                target="_blank"
                rel="noopener noreferrer"
                class="text-purple-300 hover:text-purple-200 underline"
              >
                svg icons
              </a>
              licensed by
              <a
                href="https://creativecommons.org/licenses/by/4.0/"
                target="_blank"
                rel="noopener noreferrer"
                class="text-purple-300 hover:text-purple-200 underline"
              >
                CC BY 4.0
              </a>
              •
              Slack icon made from <a
                href="https://www.svgrepo.com/svg/473790/slack"
                target="_blank"
                rel="noopener noreferrer"
                class="text-purple-300 hover:text-purple-200 underline"
              >SVG Repo</a>, Open Licensed
              •
              Service logos are trademarks of their respective owners: <a
                href="https://www.meetup.com"
                target="_blank"
                rel="noopener noreferrer"
                class="text-purple-300 hover:text-purple-200"
              >Meetup</a>, <a
                href="https://luma.com"
                target="_blank"
                rel="noopener noreferrer"
                class="text-purple-300 hover:text-purple-200"
              >Luma</a>, <a
                href="https://slack.com"
                target="_blank"
                rel="noopener noreferrer"
                class="text-purple-300 hover:text-purple-200"
              >Slack</a>, <a
                href="https://discord.com"
                target="_blank"
                rel="noopener noreferrer"
                class="text-purple-300 hover:text-purple-200"
              >Discord</a>.
            </div>
          </div>
        </div>
      </footer>
    </div>
    <script
      type="module"
      src="https://cdn.jsdelivr.net/npm/bsky-embed@0.3.0/dist/bsky-embed.es.js"
      integrity="sha384-d9v+YIdHFt8OgmsLmnRzXOiFdSMc5JoJ+xbrYZQnJlK58tPEoO2H7n7H3HEhTxpu"
      crossorigin="anonymous"
      async
    >
    </script>
    """
  end
end
