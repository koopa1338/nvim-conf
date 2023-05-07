local M = { "kylechui/nvim-surround", event = "BufReadPre" }

M.config = function()
  L("nvim-surround", function(surround)
    surround.setup {
      surrounds = {
        -- surrounding for markdown style urls
        ["l"] = {
          add = function()
            local clipboard = vim.fn.getreg("+"):gsub("\n", "")
            return {
              { "[" },
              { "](" .. clipboard .. ")" },
            }
          end,
          find = "%b[]%b()",
          delete = "^(%[)().-(%]%b())()$",
          change = {
            target = "^()()%b[]%((.-)()%)$",
            replacement = function()
              local clipboard = vim.fn.getreg("+"):gsub("\n", "")
              return {
                { "" },
                { clipboard },
              }
            end,
          },
        },
      },
    }

    -- see help for nvim-surround.aliasing
    Map("o", "ir", "i[", {})
    Map("o", "ar", "a[", {})
    Map("o", "ia", "i<", {})
    Map("o", "aa", "a<", {})
  end)
end

return M
