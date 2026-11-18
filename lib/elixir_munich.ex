defmodule ElixirMunich do
  @moduledoc """
  Static website for the Elixir, Erlang & Gleam Munich community,
  built with [Tableau](https://hexdocs.pm/tableau).
  """

  @name "Elixir, Erlang & Gleam Munich"
  @description "The official community for Elixir, Erlang & Gleam developers in Munich. Connect, learn and share knowledge with fellow BEAM enthusiasts."

  @doc "The community name, used as site title."
  def name, do: @name

  @doc "Default meta description for the site."
  def description, do: @description

  @doc """
  Builds an absolute URL for `path` using the configured site URL.

      iex> ElixirMunich.url("/images/logo.svg")
      "https://elixir-munich.org/images/logo.svg"
  """
  def url(path \\ "/") do
    {:ok, config} = Tableau.Config.get()
    String.trim_trailing(config.url, "/") <> path
  end
end
