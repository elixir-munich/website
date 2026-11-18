defmodule ElixirMunich.AppLayout do
  @moduledoc """
  The visible page frame: skyline background and the navigation header.
  """
  use Tableau.Layout, layout: ElixirMunich.RootLayout
  use Phoenix.Component

  import ElixirMunich.Components

  def template(assigns) do
    assigns = Map.put(assigns, :nav_links, nav_links())

    ~H"""
    <div
      class="min-h-screen"
      style="background: linear-gradient(135deg, rgba(59, 7, 100, 0.8), rgba(45, 16, 84, 0.9)), url('/images/munich-skyline-bg.jpg') center/cover no-repeat;"
    >
      <header class="navbar bg-base-100/10 backdrop-blur-md border-b border-white/20 relative z-40">
        <div class="navbar-start w-auto shrink-0 pl-4">
          <a href="/" class="text-white hover:text-purple-200 transition-colors">
            <div class="font-bold text-xl">
              {ElixirMunich.name()}
            </div>
          </a>
        </div>

        <div class="navbar-end w-auto flex-1">
          <ul id="nav-desktop" class="menu menu-horizontal px-1 gap-1 hidden xl:flex flex-nowrap">
            <li :for={link <- @nav_links}>
              <a
                href={link.href}
                target="_blank"
                rel="noopener noreferrer"
                class="btn btn-ghost btn-sm text-white hover:bg-white/20 text-sm px-3 py-2 whitespace-nowrap"
              >
                <.nav_icon link={link} /> {link.label}
              </a>
            </li>
          </ul>

          <div id="nav-mobile" class="dropdown dropdown-end xl:hidden relative z-50">
            <div
              tabindex="0"
              role="button"
              aria-label="Open menu"
              class="btn btn-ghost btn-md text-white px-4 py-2"
            >
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
              <li :for={link <- @nav_links}>
                <a
                  href={link.href}
                  target="_blank"
                  rel="noopener noreferrer"
                  class="flex items-center gap-3 py-3 px-4 text-base text-white hover:bg-white/20 rounded-lg"
                >
                  <.nav_icon link={link} /> {link.label}
                </a>
              </li>
            </ul>
          </div>
        </div>
      </header>

      <main class="flex-1">
        {render(@inner_content)}
      </main>
    </div>
    """
  end
end
