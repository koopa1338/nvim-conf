local M = {
  "folke/which-key.nvim",
  cond = vim.g.whichkey,
  event = "VeryLazy",
  dependencies = {
    "mrjones2014/legendary.nvim",
  },
}

M.config = function()
  L("legendary", function(legendary)
    -- this has to run before any which-key register events.
    legendary.setup()

    Map("n", "<leader>sa", ":Legendary autocmds<CR>", { silent = true })
    Map("n", "<leader>sc", ":Legendary commands<CR>", { silent = true })
    Map("n", "<leader>sf", ":Legendary functions<CR>", { silent = true })
    Map("n", "<leader>sk", ":Legendary keymaps<CR>", { silent = true })
    Map("n", "<leader>ss", ":Legendary<CR>", { silent = true })
  end)

  L("which-key", function(wk)
    wk.setup {
      plugins = {
        marks = false,
        registers = false,
      },
    }

    wk.register {
      ["<leader>"] = {
        b = {
          name = "+buffers",
          p = { "Open Previous Buffer" },
          d = { "Delete current Buffer" },
          D = { "Delete all other Buffers" },
          w = { "Wipeout current Buffer" },
          W = { "Wipeout all other Buffers" },
          m = {
            name = "+modified",
            m = {},
            x = {},
            v = {},
          },
          b = { "Show open Buffers" },
        },
        B = {
          name = "+buffers",
          D = { "Delete all other Buffers" },
          W = { "Wipe all other Buffers" },
        },
        -- crates.nvim
        c = {
          name = "+crates",
          r = { "Reload crates" },
          p = { "Open crate info popup" },
          v = { "Open crate version popup" },
          f = { "Open crate feature popup" },
          u = { "Update crate(s)" },
          a = { "Update all crates" },
          U = { "Upgrade crate(s)" },
          A = { "Upgrade all crates" },
          R = { " Open repository" },
          D = { " Open documentation" },
        },
        f = {
          name = "+finder",
          ["*"] = { "Grep String" },
          b = { "Fuzzy Find current Buffer" },
          e = { "Find Treesitter Symbols" },
          f = { "Find Files" },
          g = { "Find Git Files" },
          m = { "Find Marks" },
          r = { "Find Live Grep" },
          R = { "Find Registers" },
        },
        F = {
          name = "+finder",
          F = { "Find Files (Hidden + Ignored)" },
        },
        g = {
          -- gitsigns
          name = "+Git/Debug",
          i = {
            name = "+more",
            b = { "Toggle Current Line Blame" },
            d = { "Preview Hunk" },
          },
          u = { "Reset Hunk" },
          b = { "Toggle Line Blame" },
          ["+"] = { "Stage Hunk" },
          ["-"] = { "Undo Stage Hunk" },
          -- Neogit
          N = { "Open Neogit UI" },
          m = { "Messenger" },
          d = {
            name = "+Debug",
            b = { "Toggle Debug Breakpoint" },
            s = { "Show Debug Breakpoints" },
            c = { "Set Debug Breakpoint Condition" },
            m = { "Set Debug Log Point Message" },
            p = { "Pause Debugger" },
            S = { "Show Debug Stacks" },
            T = { "Show Debug Console" },
            o = { "Debug Step Over" },
            ["."] = { "Debug GoTo" },
            l = { "Debug Step Into" },
            h = { "Debug Step Out" },
            k = { "Debug Step Up" },
            j = { "Debug Step Down" },
            R = { "Toggle Debug REPL" },
            Q = { "Disconnect Debugger" },
            D = { "Clear All Breakpoints" },
          },
        },
        -- language server
        K = { "Show Documentation" },
        l = {
          name = "+language",
          c = {
            name = "+code",
            a = { "Select Code Actions" },
            i = { "Show Incoming Calls (quickfix)" },
            o = { "Show Outgoing Calls (quickfix)" },
          },
          d = { "Jump to Definition" },
          f = { "Format File" },
          j = { "Jump to Next Diagnostic" },
          k = { "Jump to Previous Diagnostic" },
          l = { "Line Diagnostics" },
          r = { "Rename under Cursor" },
          s = { "Show Signature Help" },
          t = {
            name = "+finder",
            d = { "Show Diagnostics (Current Buffer)" },
            i = { "Show Implementations" },
            r = { "Show References" },
            s = { "Show Document Symbols" },
            D = { "Show Diagnostics" },
            S = { "Show Workspace Symbols" },
          },
          D = { "Show Declaration" },
          T = { "Show Type Definition" },
        },
        -- treesitter
        ["<M-s>"] = { "Swap with previous parameter" },
        p = {
          name = "+peek",
          f = { "Peek outer function" },
          c = { "Peek outer class" },
          s = { "Peek outer scope" },
        },
        -- legendary.nvim
        s = {
          name = "+search",
          a = { "Search Autocmds" },
          c = { "Search Commands" },
          f = { "Search Functions" },
          k = { "Search Keymaps" },
          s = { "Search All" },
          l = {
            name = "settings",
            "Toggle ligatures (conceallevel)",
          },
        },
        -- trouble
        T = {
          name = "+Diagnostics",
          t = { "Show document diagnostics" },
          T = { "Show workspace diagnostics" },
          r = { "Refresh diagnostic window" },
        },
        -- urlview
        u = {
          name = "+urlview",
          f = { "Show URLs of File" },
          j = { "Show Jira URLs" },
          u = { "Show local URLs" },
        },
        -- diffview
        v = {
          name = "+Diffview",
          d = { "Show Diff View" },
          h = { "Show Diff History" },
        },
        w = {
          name = "+windows",
          q = { "Close current Window" },
          t = { "Close current Tab" },
          o = { "Close all other Windows" },
          n = {
            name = "+new",
            x = { "New Horizontal Window" },
            v = { "New Vertical Window" },
          },
          s = {
            name = "+split",
            x = { "Horizontal Split" },
            v = { "Vertical Split" },
          },
        },
        -- truezen
        z = { "Maximize current Window" },
        Z = { "Focus Time" },
        ["<leader>"] = {
          name = "+more",
          -- telescope
          l = { "Show Location List" },
          n = { "Show Notifications" },
          q = { "Show Quickfix" },
          H = { "Show Help Tags" },
          K = { "Show Keymaps" },
          M = { "Show Man Pages" },
          T = { "Resume Last Finder" },
          -- others
          R = { "Start resize mode" },
          N = { "Dismiss Notification" },
        },
      },
      -- dap debugger
      ["<M-d>"] = { "Start/Terminate Debugger Session" },
      -- neotree
      ["<C-n>"] = { "Toggle Neotree" },
      ["<M-C-n>"] = { "Toggle Neotree Floating Mode" },
      -- treesitter
      ["<M-s>"] = { "Swap with next parameter" },
      -- windows
      ["<C-S>"] = { "Save File" },
      ["<C-H>"] = { "Move Window Left" },
      ["<C-J>"] = { "Move Window Down" },
      ["<C-K>"] = { "Move Window Up" },
      ["<C-L>"] = { "Move Window Right" },
    }
  end)
end

return M
