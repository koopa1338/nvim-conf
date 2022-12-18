L("nvim-surround", function(surround)
  surround.setup {}
  -- see help for nvim-surround.aliasing
  Map("o", "ir", "i[", {})
  Map("o", "ar", "a[", {})
  Map("o", "ia", "i<", {})
  Map("o", "aa", "a<", {})
end)
