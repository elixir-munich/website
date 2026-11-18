defmodule ElixirMunich.Components do
  @moduledoc """
  Shared function components for layouts and pages.
  """
  use Phoenix.Component

  @doc """
  Renders a [Heroicon](https://heroicons.com).

  Icons are provided by the Tailwind plugin in `assets/vendor/heroicons.js`,
  which generates a `hero-*` class per icon.

  ## Examples

      <.icon name="hero-x-mark" />
      <.icon name="hero-arrow-path" class="ml-1 size-3" />
  """
  attr :name, :string, required: true
  attr :class, :string, default: "size-4"

  def icon(%{name: "hero-" <> _} = assigns) do
    ~H"""
    <span class={[@name, @class]} />
    """
  end

  @doc """
  Renders the icon for a navigation link: either a Heroicon, an image from
  `extra/images`, or the inline "companies" building glyph.
  """
  attr :link, :map, required: true

  def nav_icon(%{link: %{icon: {:hero, name}}} = assigns) do
    assigns = assign(assigns, :name, name)

    ~H"""
    <.icon name={@name} class="w-4 h-4" />
    """
  end

  def nav_icon(%{link: %{icon: {:image, src}}} = assigns) do
    assigns = assign(assigns, :src, src)

    ~H"""
    <img src={@src} alt={@link.label} class="w-4 h-4" />
    """
  end

  def nav_icon(%{link: %{icon: :companies}} = assigns) do
    ~H"""
    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
      <path d="M12 7V3H2v18h20V7H12zM6 19H4v-2h2v2zm0-4H4v-2h2v2zm0-4H4V9h2v2zm0-4H4V5h2v2zm4 12H8v-2h2v2zm0-4H8v-2h2v2zm0-4H8V9h2v2zm0-4H8V5h2v2zm10 12h-8v-2h2v-2h-2v-2h2v-2h-2V9h8v10zm-2-8h-2v2h2v-2zm0 4h-2v2h2v-2z" />
    </svg>
    """
  end

  @doc "Navigation links shown in the site header (desktop and mobile)."
  def nav_links do
    [
      %{
        label: "Companies",
        href: "https://github.com/elixir-munich/companies",
        icon: :companies
      },
      %{
        label: "Submit Talk",
        href: "https://github.com/elixir-munich/planning/issues/new?template=talk.yml",
        icon: {:hero, "hero-presentation-chart-bar"}
      },
      %{
        label: "Meetup",
        href: "https://www.meetup.com/elixir-munich/",
        icon: {:image, "/images/meetup-logo.svg"}
      },
      %{
        label: "Luma",
        href: "https://luma.com/elixir-munich",
        icon: {:image, "/images/luma-logo.svg"}
      },
      %{
        label: "Slack (#munich)",
        href:
          "https://join.slack.com/t/elixir-lang/shared_invite/zt-29w4dnkie-VkuKAAiVHSMmKakxrVA27w",
        icon: {:image, "/images/slack-logo.svg"}
      },
      %{
        label: "Discord",
        href: "https://discord.gg/dPMFx94RUQ",
        icon: {:image, "/images/discord-logo.svg"}
      }
    ]
  end
end
