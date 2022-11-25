L("nvim-surround", function(surround)
  surround.setup {}
  -- see help for nvim-surround.aliasing
  Map("o", "ir", "i[", { remap = false })
  Map("o", "ar", "a[", { remap = false })
  Map("o", "ia", "i<", { remap = false })
  Map("o", "aa", "a<", { remap = false })
end)
