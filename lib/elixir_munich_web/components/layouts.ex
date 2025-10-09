defmodule ElixirMunichWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use ElixirMunichWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div
      class="min-h-screen"
      style="background: linear-gradient(135deg, rgba(59, 7, 100, 0.8), rgba(45, 16, 84, 0.9)), url('/images/munich-skyline-bg.jpg') center/cover no-repeat;"
    >
      <header class="navbar bg-base-100/10 backdrop-blur-md border-b border-white/20 relative z-40">
        <div class="navbar-start pl-4">
          <a
            href="/"
            class="text-white hover:text-purple-200 transition-colors"
          >
            <div class="font-bold text-xl">
              Elixir & Erlang Munich
            </div>
          </a>
        </div>

        <div class="navbar-end">
          <ul class="menu menu-horizontal px-1 gap-1 hidden lg:flex flex-nowrap">
            <li>
              <a
                href="https://github.com/elixir-munich/companies"
                target="_blank"
                rel="noopener noreferrer"
                class="btn btn-ghost btn-sm text-white hover:bg-white/20 text-sm px-3 py-2 whitespace-nowrap"
              >
                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M12 7V3H2v18h20V7H12zM6 19H4v-2h2v2zm0-4H4v-2h2v2zm0-4H4V9h2v2zm0-4H4V5h2v2zm4 12H8v-2h2v2zm0-4H8v-2h2v2zm0-4H8V9h2v2zm0-4H8V5h2v2zm10 12h-8v-2h2v-2h-2v-2h2v-2h-2V9h8v10zm-2-8h-2v2h2v-2zm0 4h-2v2h2v-2z" />
                </svg>
                Companies
              </a>
            </li>
            <li>
              <a
                href="https://github.com/elixir-munich/planning/issues/new?template=talk.yml"
                target="_blank"
                rel="noopener noreferrer"
                class="btn btn-ghost btn-sm text-white hover:bg-white/20 text-sm px-3 py-2 whitespace-nowrap"
              >
                <.icon name="hero-presentation-chart-bar" class="w-4 h-4" /> Submit Talk
              </a>
            </li>
            <li>
              <a
                href="https://www.meetup.com/elixir-munich/"
                target="_blank"
                rel="noopener noreferrer"
                class="btn btn-ghost btn-sm text-white hover:bg-white/20 text-sm px-3 py-2 whitespace-nowrap"
              >
                <img src={~p"/images/meetup-logo.svg"} alt="Meetup" class="w-4 h-4" /> Meetup
              </a>
            </li>
            <li>
              <a
                href="https://luma.com/elixir-munich"
                target="_blank"
                rel="noopener noreferrer"
                class="btn btn-ghost btn-sm text-white hover:bg-white/20 text-sm px-3 py-2 whitespace-nowrap"
              >
                <img src={~p"/images/luma-logo.svg"} alt="Luma" class="w-4 h-4" /> Luma
              </a>
            </li>
            <li>
              <a
                href="https://join.slack.com/t/elixir-lang/shared_invite/zt-29w4dnkie-VkuKAAiVHSMmKakxrVA27w"
                target="_blank"
                rel="noopener noreferrer"
                class="btn btn-ghost btn-sm text-white hover:bg-white/20 text-sm px-3 py-2 whitespace-nowrap"
              >
                <img src={~p"/images/slack-logo.svg"} alt="Slack" class="w-4 h-4" /> Slack (#munich)
              </a>
            </li>
            <li>
              <a
                href="https://discord.gg/dPMFx94RUQ"
                target="_blank"
                rel="noopener noreferrer"
                class="btn btn-ghost btn-sm text-white hover:bg-white/20 text-sm px-3 py-2 whitespace-nowrap"
              >
                <img src={~p"/images/discord-logo.svg"} alt="Discord" class="w-4 h-4" /> Discord
              </a>
            </li>
          </ul>

          <div class="dropdown dropdown-end lg:hidden relative z-50">
            <div tabindex="0" role="button" class="btn btn-ghost btn-md text-white px-4 py-2">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M4 6h16M4 12h16M4 18h16"
                >
                </path>
              </svg>
            </div>
            <ul
              tabindex="0"
              class="dropdown-content menu p-2 shadow-xl bg-[#1a0f2e]/95 backdrop-blur-md border border-white/20 rounded-xl w-64 mt-2 z-50 fixed"
            >
              <li>
                <a
                  href="https://github.com/elixir-munich/companies"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="py-3 px-4 text-base text-white hover:bg-white/20 rounded-lg"
                >
                  <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M12 7V3H2v18h20V7H12zM6 19H4v-2h2v2zm0-4H4v-2h2v2zm0-4H4V9h2v2zm0-4H4V5h2v2zm4 12H8v-2h2v2zm0-4H8v-2h2v2zm0-4H8V9h2v2zm0-4H8V5h2v2zm10 12h-8v-2h2v-2h-2v-2h2v-2h-2V9h8v10zm-2-8h-2v2h2v-2zm0 4h-2v2h2v-2z" />
                  </svg>
                  Companies
                </a>
              </li>
              <li>
                <a
                  href="https://github.com/elixir-munich/planning/issues/new?template=talk.yml"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="py-3 px-4 text-base text-white hover:bg-white/20 rounded-lg"
                >
                  <.icon name="hero-presentation-chart-bar" class="w-4 h-4" /> Submit Talk
                </a>
              </li>
              <li>
                <a
                  href="https://www.meetup.com/elixir-munich/"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="flex items-center gap-3 py-3 px-4 text-base text-white hover:bg-white/20 rounded-lg"
                >
                  <img src={~p"/images/meetup-logo.svg"} alt="Meetup" class="w-4 h-4" /> Meetup
                </a>
              </li>
              <li>
                <a
                  href="https://luma.com/elixir-munich"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="flex items-center gap-3 py-3 px-4 text-base text-white hover:bg-white/20 rounded-lg"
                >
                  <img src={~p"/images/luma-logo.svg"} alt="Luma" class="w-4 h-4" /> Luma
                </a>
              </li>
              <li>
                <a
                  href="https://join.slack.com/t/elixir-lang/shared_invite/zt-29w4dnkie-VkuKAAiVHSMmKakxrVA27w"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="flex items-center gap-3 py-3 px-4 text-base text-white hover:bg-white/20 rounded-lg"
                >
                  <img src={~p"/images/slack-logo.svg"} alt="Slack" class="w-4 h-4" /> Slack (#munich)
                </a>
              </li>
              <li>
                <a
                  href="https://discord.gg/dPMFx94RUQ"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="flex items-center gap-3 py-3 px-4 text-base text-white hover:bg-white/20 rounded-lg"
                >
                  <img src={~p"/images/discord-logo.svg"} alt="Discord" class="w-4 h-4" /> Discord
                </a>
              </li>
            </ul>
          </div>
        </div>
      </header>

      <main class="flex-1">
        {render_slot(@inner_block)}
      </main>
    </div>

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end
end
