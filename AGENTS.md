This is a static website built with [Tableau](https://hexdocs.pm/tableau), an Elixir static site generator. Pages are HEEx templates rendered at build time; there is no server, LiveView, database, or JavaScript bundle. The output in `_site/` is deployed to GitHub Pages.

## Project guidelines

- Use `mix precommit` when you are done with all changes and fix any pending issues (compile with warnings as errors, format, `credo --strict` incl. ExSlop checks, tests)
- `mix tableau.server` runs the dev server with live reload on http://localhost:4999; `MIX_ENV=prod mix build` writes the production site to `_site/`
- Avoid adding dependencies unless asked. Anything added must pass `mix hex.audit` and `mix deps.audit` (CI runs both); fix advisories by updating, never by ignoring them

### Tableau guidelines

- Each page is a module in `lib/elixir_munich/pages/` that does `use Tableau.Page, layout: ElixirMunich.AppLayout, permalink: "/path"` plus `use Phoenix.Component`, and defines `template/1` returning `~H`
- Any extra options passed to `use Tableau.Page` (e.g. `title:`, `description:`) are available as `@page.title` etc. and are used by `ElixirMunich.RootLayout` for `<title>` and meta tags
- Layouts use `use Tableau.Layout` and render nested content with `{render(@inner_content)}`. `RootLayout` (document `<head>`) wraps `AppLayout` (background + header)
- Layout/page assigns are plain maps from Tableau, **not** LiveView assigns: use `Map.put/3` / `Map.merge/2`, not `assign/3`, inside layout and page `template/1` functions (`assign/3` is fine inside function components called with `<.component>`)
- Shared function components live in `ElixirMunich.Components` (e.g. `<.icon name="hero-x-mark" class="w-5 h-5" />` for Heroicons). **Always** use `<.icon>` for icons
- Static files (images, favicon, robots.txt) go in `extra/` and are copied to the site root; reference them with root-relative paths like `/images/foo.svg`
- Use `ElixirMunich.url/1` when an absolute URL is required (Open Graph, canonical links)
- Test pages by building the site and asserting on the output with `LazyHTML` (see `test/site_build_test.exs`), using element IDs rather than text where possible

### CSS guidelines

- **Use Tailwind CSS classes and custom CSS rules** to create polished, responsive, and visually stunning interfaces.
- Tailwind v4 **no longer needs a tailwind.config.js** and uses this import syntax in `assets/css/app.css`; **always** keep it:

      @import "tailwindcss" source(none);
      @source "../css";
      @source "../../lib";

- **Never** use `@apply` when writing raw css
- The site currently uses daisyUI component classes (vendored in `assets/vendor`); prefer hand-written Tailwind for new components
- There is no JS bundle. **Never** write inline `<script>` tags with custom JS in templates; the only script is the external `bsky-embed` web component

### UI/UX & design guidelines

- **Produce world-class UI designs** with a focus on usability, aesthetics, and modern design principles
- Implement **subtle micro-interactions** (e.g., button hover effects, and smooth transitions)
- Ensure **clean typography, spacing, and layout balance** for a refined, premium look

## Elixir guidelines

- Elixir lists **do not support index based access via the access syntax**

  **Never do this (invalid)**:

      i = 0
      mylist = ["blue", "green"]
      mylist[i]

  Instead, **always** use `Enum.at`, pattern matching, or `List` for index based list access, ie:

      i = 0
      mylist = ["blue", "green"]
      Enum.at(mylist, i)

- Elixir variables are immutable, but can be rebound, so for block expressions like `if`, `case`, `cond`, etc
  you *must* bind the result of the expression to a variable if you want to use it and you CANNOT rebind the result inside the expression, ie:

      # INVALID: we are rebinding inside the `if` and the result never gets assigned
      if connected?(socket) do
        socket = assign(socket, :val, val)
      end

      # VALID: we rebind the result of the `if` to a new variable
      socket =
        if connected?(socket) do
          assign(socket, :val, val)
        end

- **Never** nest multiple modules in the same file as it can cause cyclic dependencies and compilation errors
- **Never** use map access syntax (`changeset[:field]`) on structs as they do not implement the Access behaviour by default. For regular structs, you **must** access the fields directly, such as `my_struct.field` or use higher level APIs that are available on the struct if they exist, `Ecto.Changeset.get_field/2` for changesets
- Elixir's standard library has everything necessary for date and time manipulation. Familiarize yourself with the common `Time`, `Date`, `DateTime`, and `Calendar` interfaces by accessing their documentation as necessary. **Never** install additional dependencies unless asked or for date/time parsing (which you can use the `date_time_parser` package)
- Don't use `String.to_atom/1` on user input (memory leak risk)
- Predicate function names should not start with `is_` and should end in a question mark. Names like `is_thing` should be reserved for guards
- Elixir's builtin OTP primitives like `DynamicSupervisor` and `Registry`, require names in the child spec, such as `{DynamicSupervisor, name: MyApp.MyDynamicSup}`, then you can use `DynamicSupervisor.start_child(MyApp.MyDynamicSup, child_spec)`
- Use `Task.async_stream(collection, callback, options)` for concurrent enumeration with back-pressure. The majority of times you will want to pass `timeout: :infinity` as option

## Mix guidelines

- Read the docs and options before using tasks (by using `mix help task_name`)
- To debug test failures, run tests in a specific file with `mix test test/my_test.exs` or run all previously failed tests with `mix test --failed`
- `mix deps.clean --all` is **almost never needed**. **Avoid** using it unless you have good reason

## HEEx guidelines

- Phoenix templates **always** use `~H` or .html.heex files (known as HEEx), **never** use `~E`
- **Always** add unique DOM IDs to key elements (like forms, buttons, etc) when writing templates, these IDs can later be used in tests (`<.form for={@form} id="product-form">`)
- Elixir supports `if/else` but **does NOT support `if/else if` or `if/elsif`. **Never use `else if` or `elseif` in Elixir**, **always** use `cond` or `case` for multiple conditionals.

  **Never do this (invalid)**:

      <%= if condition do %>
        ...
      <% else if other_condition %>
        ...
      <% end %>

  Instead **always** do this:

      <%= cond do %>
        <% condition -> %>
          ...
        <% condition2 -> %>
          ...
        <% true -> %>
          ...
      <% end %>

- HEEx require special tag annotation if you want to insert literal curly's like `{` or `}`. If you want to show a textual code snippet on the page in a `<pre>` or `<code>` block you *must* annotate the parent tag with `phx-no-curly-interpolation`:

      <code phx-no-curly-interpolation>
        let obj = {key: "val"}
      </code>

  Within `phx-no-curly-interpolation` annotated tags, you can use `{` and `}` without escaping them, and dynamic Elixir expressions can still be used with `<%= ... %>` syntax

- HEEx class attrs support lists, but you must **always** use list `[...]` syntax. You can use the class list syntax to conditionally add classes, **always do this for multiple class values**:

      <a class={[
        "px-2 text-white",
        @some_flag && "py-5",
        if(@other_condition, do: "border-red-500", else: "border-blue-100"),
        ...
      ]}>Text</a>

  and **always** wrap `if`'s inside `{...}` expressions with parens, like done above (`if(@other_condition, do: "...", else: "...")`)

  and **never** do this, since it's invalid (note the missing `[` and `]`):

      <a class={
        "px-2 text-white",
        @some_flag && "py-5"
      }> ...
      => Raises compile syntax error on invalid HEEx attr syntax

- **Never** use `<% Enum.each %>` or non-for comprehensions for generating template content, instead **always** use `<%= for item <- @collection do %>`
- HEEx HTML comments use `<%!-- comment --%>`. **Always** use the HEEx HTML comment syntax for template comments (`<%!-- comment --%>`)
- HEEx allows interpolation via `{...}` and `<%= ... %>`, but the `<%= %>` **only** works within tag bodies. **Always** use the `{...}` syntax for interpolation within tag attributes, and for interpolation of values within tag bodies. **Always** interpolate block constructs (if, cond, case, for) within tag bodies using `<%= ... %>`.

  **Always** do this:

      <div id={@id}>
        {@my_assign}
        <%= if @some_block_condition do %>
          {@another_assign}
        <% end %>
      </div>

  and **Never** do this – the program will terminate with a syntax error:

      <%!-- THIS IS INVALID NEVER EVER DO THIS --%>
      <div id="<%= @invalid_interpolation %>">
        {if @invalid_block_construct do}
        {end}
      </div>
