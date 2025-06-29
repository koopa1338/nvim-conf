return {
  cmd = { "clangd" },
  filetypes = { "c", "cc", "cpp", "objc", "objcpp", "h", "hh", "hpp" },
  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    ".clangd",
    "CMakeLists.txt",
    "Makefile",
    ".git",
    vim.uv.cwd(),
  },
}
