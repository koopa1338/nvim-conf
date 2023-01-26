local M = { "tamton-aquib/staline.nvim" }

M.config = function()
  L("staline", function(sl)
    local git = function()
      return vim.b.gitsigns_status or ""
    end

    local encoding = function()
      return vim.bo.fileencoding:upper()
    end

    local lsp_diag = function()
      if vim.diagnostic == nil then
        return ""
      end
      if #vim.diagnostic.get(0) == 0 then
        return ""
      end
      local severities = {
        "Error",
        "Warn",
        "Hint",
        "Info",
      }
      local diag = " "

      for _, s in ipairs(severities) do
        local diagnostic = #vim.diagnostic.get(0, { severity = s })
        if diagnostic ~= nil then
          if diagnostic > 0 then
            local sign_name = "DiagnosticSign" .. s
            local sign = Get_sign_def(sign_name).icon
            if sign ~= nil then
              diag = diag .. sign .. diagnostic .. " "
            end
          end
        end
      end
      return { "StatusLine", diag }
    end

    local has_diag = function()
      return vim.diagnostic ~= nil and #vim.diagnostic.get(0) > 0
    end

    local diag_pre = function()
      if has_diag() then
        return { "SatusLineSeperator", "" }
      end
      return ""
    end

    local diag_suf = function()
      if has_diag() then
        return { "SatusLineSeperator", "" }
      end
      return ""
    end

    sl.setup {
      sections = {
        left = {
          "-mode",
          "-branch",
          "- ",
          { "StalineFill", git },
          "- ",
          "left_sep_double",
          " ",
        },
        mid = {
          { "SatusLineSeperator", "right_sep" },
          { "StatusLine", " " },
          { "StatusLine", "file_name" },
          { "StatusLine", " " },
          { "SatusLineSeperator", "left_sep" },
        },
        right = {
          "right_sep_double",
          "- ",
          "-lsp_name",
          "- ",
          "",
          " ",
          diag_pre,
          lsp_diag,
          diag_suf,
          " ",
          encoding,
          " ",
          "right_sep",
          "-line_column",
        },
      },
      defaults = {
        left_separator = "",
        right_separator = "",
        line_column = "%l:%c [%L]",
        true_colors = false,
        -- line_column = "[%l:%c] 並%p%% ",
        font_active = "bold",
        -- bg = line_hl.bg
      },
    }
  end)
end

return M
