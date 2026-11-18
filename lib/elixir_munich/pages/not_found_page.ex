defmodule ElixirMunich.NotFoundPage do
  @moduledoc """
  Rendered to `404.html`, which GitHub Pages serves for unknown paths.
  """
  use Tableau.Page,
    layout: ElixirMunich.AppLayout,
    permalink: "/404.html",
    title: "Page not found"

  use Phoenix.Component

  def template(assigns) do
    ~H"""
    <div class="container mx-auto px-4 py-24">
      <div
        id="not-found"
        class="max-w-lg mx-auto text-center text-white bg-base-100/10 backdrop-blur-md rounded-3xl shadow-xl border border-white/20 p-12"
      >
        <p class="text-6xl font-bold mb-4">404</p>
        <h1 class="text-2xl font-bold mb-2">Page not found</h1>
        <p class="opacity-80 mb-8">This page doesn't exist, or it moved.</p>
        <a href="/" class="btn btn-ghost text-white border border-white/20 hover:bg-white/20">
          Back to the homepage
        </a>
      </div>
    </div>
    """
  end
end
