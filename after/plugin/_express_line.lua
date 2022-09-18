local el = L "el"
if not el then
  return
end

local builtin = require "el.builtin"
local extensions = require "el.extensions"
local sections = require "el.sections"
local subscribe = require "el.subscribe"
local lsp_statusline = require "el.plugins.lsp_status"

local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
  local branch = extensions.git_branch(window, buffer)
  if branch then
    return " " .. extensions.git_icon() .. " " .. branch
  end
end)

local file_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufffer)
  local icon = extensions.file_icon(_, bufffer)
  if icon then
    return icon .. " "
  end
  return ""
end)

local git_changes = subscribe.buf_autocmd("el_git_changes", "BufWritePost", function(window, buffer)
  return extensions.git_changes(window, buffer)
end)

el.setup {
  generator = function(window, buffer)
    return {
      extensions.gen_mode {
        format_string = " %s ",
      },
      git_branch(window, buffer),
      sections.split,
      file_icon(window, buffer),
      builtin.tail_file,
      sections.split,
      lsp_statusline.segment,
      git_changes(window, buffer),
      "[",
      builtin.line_with_width(3),
      ":",
      builtin.column_with_width(2),
      "]",
      sections.collapse_builtin {
        "[",
        builtin.help_list,
        builtin.readonly_list,
        "]",
      },
      builtin.filetype,
    }
  end,
}
