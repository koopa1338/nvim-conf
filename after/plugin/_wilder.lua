L("wilder", function(wilder)
  wilder.setup {
    modes = { ":", "/", "?" },
    next_key = "<Tab>",
    previous_key = "<S-Tab>",
    accept_key = "<Down>",
    reject_key = "<Up>",
  }
  wilder.set_option("pipeline", {
    wilder.branch(
      wilder.python_file_finder_pipeline {
        file_command = { "rg", "--files" },
        dir_command = { "fd", "-td" },
      },
      wilder.cmdline_pipeline(),
      wilder.python_search_pipeline()
    ),
  })
  wilder.set_option(
    "renderer",
    wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
      highlighter = wilder.lua_fzy_highlighter(),
      highlights = {
        border = "FloatBorder",
        accent = wilder.make_hl(
          "WilderAccent",
          "Pmenu",
          { { a = true }, { a = true }, { foreground = Get_theme_hl("Special").fg, bold = true } }
        ),
      },
      left = { " ", wilder.popupmenu_devicons() },
      right = { " ", wilder.popupmenu_scrollbar() },
      border = vim.g.border_type,
    })
  )
end)
