L("mason", function(mason)
  mason.setup {
    ui = {
      border = vim.g.border_type,
      icons = {
        package_installed = "",
        package_pending = "➤",
        package_uninstalled = "",
      },
    },
  }
end)
