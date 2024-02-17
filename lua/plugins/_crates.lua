local M = {
  "saecki/crates.nvim",
  event = "BufRead Cargo.toml",
  dependencies = { "nvim-lua/plenary.nvim" },
}

M.config = function()
  L("crates", function(crates)
    crates.setup { popup = { autofocus = true, border = vim.g.border_type } }

    Map("n", "<leader>cr", crates.reload, { silent = true, buffer = true, desc = "Reload crates" })
    Map("n", "<leader>cp", crates.show_popup, { silent = true, buffer = true, desc = "Open crate info popup" })

    Map(
      "n",
      "<leader>cv",
      crates.show_versions_popup,
      { silent = true, buffer = true, desc = "Open crate version popup" }
    )
    Map(
      "n",
      "<leader>cf",
      crates.show_features_popup,
      { silent = true, buffer = true, desc = "Open crate feature popup" }
    )

    Map("n", "<leader>cu", crates.update_crate, { silent = true, buffer = true, desc = "Update crate" })
    Map("v", "<leader>cu", crates.update_crates, { silent = true, buffer = true, desc = "Update multiple crates" })
    Map(
      { "n", "v" },
      "<leader>ca",
      crates.update_all_crates,
      { silent = true, buffer = true, desc = "update all crates" }
    )

    Map("n", "<leader>cU", crates.upgrade_crate, { silent = true, buffer = true, desc = "Upgrade crate" })
    Map("v", "<leader>cU", crates.upgrade_crates, { silent = true, buffer = true, desc = "Upgrade multiple crates" })
    Map(
      { "n", "v" },
      "<leader>cA",
      crates.upgrade_all_crates,
      { silent = true, buffer = true, desc = "Upgrade all crates" }
    )

    Map("n", "<leader>cR", crates.open_repository, { silent = true, buffer = true, desc = "Open repository" })
    Map("n", "<leader>cD", crates.open_documentation, { silent = true, buffer = true, desc = "Open documentation" })
  end)
end

return M
