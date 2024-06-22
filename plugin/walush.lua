-- set font for gui mode
vim.opt.guifont = "Inconsolata Nerd Font Mono:h14"

Get_theme_hl = function(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  for _, key in pairs { "foreground", "background", "special" } do
    if hl[key] then
      hl[key] = string.format("#%06x", hl[key])
    end
  end
  return hl
end

L("lush", function(lush)
  local hsl = lush.hsl
  local xres = table.clone(Colors_or_default())
  xres.diffgreen = "#002800"
  xres.diffred = "#3f0000"
  xres.yellow = "#3f3f00"

  for name, color in pairs(xres) do
    xres[name] = hsl(color)
  end
  xres.none = "NONE"

  ---@diagnostic disable: undefined-global, undefined-field
  local theme = lush(function(injected_functions)
    -- you probably want to alias it locally
    local sym = injected_functions.sym
    return {
      -- git
      DiffAdd { fg = xres.None, bg = xres.diffgreen },
      DiffDelete { fg = xres.None, bg = xres.diffred },
      DiffChange { fg = xres.None, bg = DiffAdd.bg.ro(60) },
      DiffText { fg = xres.None, bg = DiffAdd.bg.lighten(2.5) },

      -- Diagnostics
      DiagnosticError { fg = DiffDelete.bg.lighten(35) },
      DiagnosticWarn { fg = xres.yellow.lighten(35) },
      DiagnosticWarning { DiagnosticWarn },
      DiagnosticInfo { fg = xres.color15, bg = xres.bg.lighten(15) },
      DiagnosticHint { fg = xres.color7 },
      DiagnosticUnderlineError { fg = DiagnosticError.fg, gui = "underline" },
      DiagnosticUnderlineWarn { fg = DiagnosticWarn.fg, gui = "underline" },
      DiagnosticUnderlineInfo { fg = DiagnosticInfo.fg, gui = "underline" },
      DiagnosticUnderlineHint { fg = DiagnosticHint.fg, gui = "underline" },
      DiagnosticVirtualTextError { DiagnosticError },
      DiagnosticVirtualTextWarn { DiagnosticWarn },
      DiagnosticVirtualTextInfo { DiagnosticInfo },
      DiagnosticVirtualTextHint { DiagnosticHint },
      DiagnosticFloatingError { DiagnosticError },
      DiagnosticFloatingWarn { DiagnosticWarn },
      DiagnosticFloatingInfo { DiagnosticInfo },
      DiagnosticFloatingHint { DiagnosticHint },
      DiagnosticSignError { DiagnosticError },
      DiagnosticSignWarn { DiagnosticWarn },
      DiagnosticSignInfo { DiagnosticInfo },
      DiagnosticSignHint { DiagnosticHint },

      -- General
      SpecialKey { fg = xres.color13, bg = xres.color0 },
      TermCursor { gui = "reverse" },
      NonText { fg = xres.bg.lighten(20), bg = xres.None },
      EndOfBuffer { NonText },
      Directory { fg = xres.color11, bg = xres.bg },
      ErrorMsg { fg = xres.color0, bg = xres.color9 },
      Search { gui = "reverse" },
      MoreMsg { fg = xres.color15, bg = xres.bg },
      ModeMsg { fg = xres.none, bg = xres.none, gui = "bold" },
      LineNr { fg = xres.color7, bg = xres.color0 },
      LineNrAbove { LineNr },
      LineNrBelow { LineNr },
      CursorLineNr { fg = xres.color15, bg = xres.color8.lighten(2.5), gui = "bold" },
      Type { fg = xres.color14, bg = xres.bg, gui = "bold" },
      Question { Type },
      StatusLine { fg = xres.color15, bg = xres.color8, gui = "bold" },
      StatusLineNC { fg = xres.color15, bg = xres.color8 },
      Comment { fg = xres.color4, bg = xres.color0 },
      SignColumn { fg = xres.color12, bg = xres.none },
      VertSplit { fg = xres.color0, bg = xres.color8, gui = "reverse" },
      Title { fg = xres.fg.lighten(25), bg = xres.bg },
      WildMenu { fg = xres.color0, bg = xres.color11 },
      Keyword { fg = xres.color13 },
      Pmenu { fg = xres.color15, bg = xres.bg },
      PmenuSel { fg = xres.none, bg = xres.bg.lighten(15) },
      PmenuSbar { fg = xres.fg.lighten(25) },
      PmenuThumb { fg = xres.fg, bg = xres.color15 },
      QuickFixLine { Search },
      Substitute { Search },
      Whitespace { NonText },
      MsgSeparator { StatusLine },
      Label { Type },
      Operator { Type },
      StorageClass { Type },
      Structure { Type },
      NvimNumberPrefix { Type },
      NvimOptionSigil { Type },
      Normal { fg = xres.color15, bg = xres.color0 },
      NormalFloat { fg = Normal.fg, bg = xres.bg.lighten(1.5) },
      NvimSpacing { Normal },
      Delimiter { fg = xres.color15, bg = xres.color8 },
      NvimParenthesis { Delimiter },
      NvimColon { Delimiter },
      NvimComma { Delimiter },
      NvimArrow { Delimiter },
      Constant { fg = xres.color11, bg = xres.bg },
      String { Constant },
      Character { Constant },
      Visual { fg = xres.None, bg = xres.color0.lighten(15) },
      Function { fg = xres.color9.ro(15).lighten(15), bg = xres.bg },
      Special { fg = xres.color9 },
      Tag { Special },
      Debug { Special },
      PreProc { fg = xres.color10 },
      Include { PreProc },
      Define { PreProc },
      Macro { PreProc },
      PreCondit { PreProc },
      Conditional { fg = xres.color11 },
      Repeat { Conditional },
      Statement { fg = xres.color10, gui = "bold" },
      Method {},
      Boolean { Statement },
      FloatTitle { fg = xres.color0, bg = xres.fg, gui = "bold" },
      FloatBorder { fg = FloatTitle.bg, bg = xres.bg.lighten(1.5) },
      SpecialChar { fg = xres.color12, bg = xres.color8 },
      SpecialComment { fg = xres.color11, bg = xres.color8 },
      FoldColumn { fg = xres.color14, bg = xres.bg },
      Folded { FoldColumn },
      WarningMsg { fg = xres.color10 },
      Conceal { fg = xres.color7 },
      SpellBad { fg = xres.color8, bg = xres.color9 },
      SpellCap { bg = xres.color12.da(25), gui = "undercurl" },
      SpellRare { bg = xres.color13.da(55), gui = "undercurl" },
      SpellLocal { bg = xres.color8, gui = "undercurl" },
      CursorColumn {},
      CursorLine { bg = xres.color0 },
      ColorColumn { fg = xres.none, bg = xres.color1 },
      NormalNC {},
      MsgArea {},
      RedrawDebugNormal { gui = "reverse" },
      RedrawDebugClear { bg = xres.color11.ro(180).lighten(70) },
      RedrawDebugComposed { bg = xres.color10.da(50) },
      RedrawDebugRecompose { bg = xres.color9.da(50) },
      Cursor { fg = xres.bg, bg = xres.fg },
      lCursor { fg = xres.bg, bg = xres.fg },
      FloatShadow { fg = xres.fg.lighten(15), bg = xres.bg.lighten(15) },
      FloatShadowThrough { fg = xres.color15, bg = xres.bg },
      Error { DiagnosticError },
      Todo { fg = xres.color14, bg = xres.color8 },
      Number { fg = xres.color12 },
      Float { fg = xres.color12 },
      Identifier { fg = xres.color12 },
      Exception { fg = xres.color10, bg = xres.color0 },
      Typedef { fg = xres.color10, bg = xres.color0, gui = "bold" },
      MatchParen { fg = xres.color12, bg = xres.color8 },
      Underlined { fg = xres.color12, gui = "underline" },
      Ignore { fg = xres.color0.lighten(15) },
      User1 { fg = xres.color15, bg = xres.color6 },
      User2 { fg = xres.color15, bg = xres.color8 },
      SatusLineSeperator { fg = xres.color8, bg = xres.None },
      StatusLineTerm { fg = xres.color0 },
      StatusLineTermNC { fg = xres.color15, bg = xres.color8 },
      YCMWarningSection { fg = xres.color0, bg = xres.color4 },
      debugPC {},

      LspReferenceText { bg = xres.color0.lighten(10) },
      LspReferenceRead { SpecialKey },
      LspReferenceWrite { fg = LspReferenceRead.fg.darken(25), bg = LspReferenceRead.bg },
      LspInfoBorder { FloatBorder },
      LspInfoTitle { FloatTitle },
      LspInfoList { fg = xres.color3, bg = xres.bg },
      LspInfoTip { fg = xres.color10, bg = xres.bg },

      -- diff
      diffOnly { Constant },
      diffIdentical { Constant },
      diffDiffer { Constant },
      diffBDiffer { Constant },
      diffIsA { Constant },
      diffNoEOL { Constant },
      diffCommon { Constant },
      diffRemoved { DiffDelete },
      diffAdded { DiffAdd },
      diffChanged { DiffChange },
      diffSubname { PreProc },
      diffLine { Statement },
      diffFile { Type },
      diffOldFile { fg = DiffDelete.bg.lighten(20) },
      diffNewFile { fg = DiffAdd.bg.lighten(20) },
      diffIndexLine { PreProc },
      diffComment { Comment },

      DiffviewFilePanelCounter { fg = xres.color3, bg = xres.None, gui = "bold" },

      -- Gitsigns
      GitSignsDelete { fg = diffOldFile.fg.lighten(30) },
      GitSignsDeleteNr { fg = GitSignsDelete.fg },
      GitSignsAdd { fg = diffNewFile.fg.lighten(15) },
      GitSignsAddNr { fg = GitSignsAdd.fg },
      GitSignsChange { fg = DiffAdd.bg.ro(30).lighten(30) },
      GitSignsChangeNr { fg = GitSignsChange.fg },
      GitSignsCurrentLineBlame { fg = NonText.fg.lighten(10) },

      GitSignsDeleteNr = { GitSignsDeleteNr },
      GitSignsUntrackedNr = { GitSignsAddNr },
      GitSignsTopdeleteNr = { GitSignsDeleteNr },
      GitSignsChangedeleteNr = { GitSignsChangeNr },

      -- Nvim groups
      NvimString { String },
      NvimStringBody { NvimString },
      NvimStringQuote { NvimString },
      NvimStringSpecial { SpecialChar },
      NvimSingleQuote { NvimStringQuote },
      NvimSingleQuotedBody { NvimStringBody },
      NvimSingleQuotedQuote { NvimStringSpecial },
      NvimDoubleQuote { NvimStringQuote },
      NvimDoubleQuotedBody { NvimStringBody },
      NvimDoubleQuotedEscape { NvimStringSpecial },
      NvimInternalError { fg = xres.color9, bg = xres.color9.da(50) },
      NvimAssignment { Operator },
      NvimPlainAssignment { NvimAssignment },
      NvimAugmentedAssignment { NvimAssignment },
      NvimAssignmentWithAddition { NvimAugmentedAssignment },
      NvimAssignmentWithSubtraction { NvimAugmentedAssignment },
      NvimAssignmentWithConcatenation { NvimAugmentedAssignment },
      NvimOperator { Operator },
      NvimUnaryOperator { NvimOperator },
      NvimUnaryPlus { NvimUnaryOperator },
      NvimUnaryMinus { NvimUnaryOperator },
      NvimNot { NvimUnaryOperator },
      NvimBinaryOperator { NvimOperator },
      NvimComparison { NvimBinaryOperator },
      NvimComparisonModifier { NvimComparison },
      NvimBinaryPlus { NvimBinaryOperator },
      NvimBinaryMinus { NvimBinaryOperator },
      NvimConcat { NvimBinaryOperator },
      NvimConcatOrSubscript { NvimConcat },
      NvimOr { NvimBinaryOperator },
      NvimAnd { NvimBinaryOperator },
      NvimMultiplication { NvimBinaryOperator },
      NvimDivision { NvimBinaryOperator },
      NvimMod { NvimBinaryOperator },
      NvimTernary { NvimOperator },
      NvimTernaryColon { NvimTernary },
      NvimLambda { NvimParenthesis },
      NvimNestingParenthesis { NvimParenthesis },
      NvimCallingParenthesis { NvimParenthesis },
      NvimSubscript { NvimParenthesis },
      NvimSubscriptBracket { NvimSubscript },
      NvimSubscriptColon { NvimSubscript },
      NvimCurly { NvimString },
      NvimContainer { NvimParenthesis },
      NvimDict { NvimContainer },
      NvimList { NvimContainer },
      NvimIdentifier { Identifier },
      NvimIdentifierScope { NvimIdentifier },
      NvimIdentifierScopeDelimiter { NvimIdentifier },
      NvimIdentifierName { NvimIdentifier },
      NvimIdentifierKey { NvimIdentifier },
      NvimRegister { SpecialChar },
      NvimNumber { Number },
      NvimFloat { NvimNumber },
      NvimOptionName { NvimIdentifier },
      NvimOptionScope { NvimIdentifierScope },
      NvimOptionScopeDelimiter { NvimIdentifierScopeDelimiter },
      NvimEnvironmentSigil { NvimOptionSigil },
      NvimEnvironmentName { NvimIdentifier },
      NvimFigureBrace { NvimInternalError },
      NvimSingleQuotedUnknownEscape { NvimInternalError },
      NvimInvalidSingleQuotedUnknownEscape { NvimInternalError },
      NvimInvalid { Error },
      NvimInvalidAssignment { NvimInvalid },
      NvimInvalidPlainAssignment { NvimInvalidAssignment },
      NvimInvalidAugmentedAssignment { NvimInvalidAssignment },
      NvimInvalidAssignmentWithAddition { NvimInvalidAugmentedAssignment },
      NvimInvalidAssignmentWithSubtraction { NvimInvalidAugmentedAssignment },
      NvimInvalidAssignmentWithConcatenation { NvimInvalidAugmentedAssignment },
      NvimInvalidOperator { NvimInvalid },
      NvimInvalidUnaryOperator { NvimInvalidOperator },
      NvimInvalidUnaryPlus { NvimInvalidUnaryOperator },
      NvimInvalidUnaryMinus { NvimInvalidUnaryOperator },
      NvimInvalidNot { NvimInvalidUnaryOperator },
      NvimInvalidBinaryOperator { NvimInvalidOperator },
      NvimInvalidComparison { NvimInvalidBinaryOperator },
      NvimInvalidComparisonModifier { NvimInvalidComparison },
      NvimInvalidBinaryPlus { NvimInvalidBinaryOperator },
      NvimInvalidBinaryMinus { NvimInvalidBinaryOperator },
      NvimInvalidConcat { NvimInvalidBinaryOperator },
      NvimInvalidConcatOrSubscript { NvimInvalidConcat },
      NvimInvalidOr { NvimInvalidBinaryOperator },
      NvimInvalidAnd { NvimInvalidBinaryOperator },
      NvimInvalidMultiplication { NvimInvalidBinaryOperator },
      NvimInvalidDivision { NvimInvalidBinaryOperator },
      NvimInvalidMod { NvimInvalidBinaryOperator },
      NvimInvalidTernary { NvimInvalidOperator },
      NvimInvalidTernaryColon { NvimInvalidTernary },
      NvimInvalidDelimiter { NvimInvalid },
      NvimInvalidParenthesis { NvimInvalidDelimiter },
      NvimInvalidLambda { NvimInvalidParenthesis },
      NvimInvalidNestingParenthesis { NvimInvalidParenthesis },
      NvimInvalidCallingParenthesis { NvimInvalidParenthesis },
      NvimInvalidSubscript { NvimInvalidParenthesis },
      NvimInvalidSubscriptBracket { NvimInvalidSubscript },
      NvimInvalidSubscriptColon { NvimInvalidSubscript },
      NvimInvalidCurly { NvimInvalidSubscript },
      NvimInvalidContainer { NvimInvalidParenthesis },
      NvimInvalidDict { NvimInvalidContainer },
      NvimInvalidList { NvimInvalidContainer },
      NvimInvalidValue { NvimInvalid },
      NvimInvalidIdentifier { NvimInvalidValue },
      NvimInvalidIdentifierScope { NvimInvalidIdentifier },
      NvimInvalidIdentifierScopeDelimiter { NvimInvalidIdentifier },
      NvimInvalidIdentifierName { NvimInvalidIdentifier },
      NvimInvalidIdentifierKey { NvimInvalidIdentifier },
      NvimInvalidColon { NvimInvalidDelimiter },
      NvimInvalidComma { NvimInvalidDelimiter },
      NvimInvalidArrow { NvimInvalidDelimiter },
      NvimInvalidRegister { NvimInvalidValue },
      NvimInvalidNumber { NvimInvalidValue },
      NvimInvalidFloat { NvimInvalidNumber },
      NvimInvalidNumberPrefix { NvimInvalidNumber },
      NvimInvalidOptionSigil { NvimInvalidIdentifier },
      NvimInvalidOptionName { NvimInvalidIdentifier },
      NvimInvalidOptionScope { NvimInvalidIdentifierScope },
      NvimInvalidOptionScopeDelimiter { NvimInvalidIdentifierScopeDelimiter },
      NvimInvalidEnvironmentSigil { NvimInvalidOptionSigil },
      NvimInvalidEnvironmentName { NvimInvalidIdentifier },
      NvimInvalidString { NvimInvalidValue },
      NvimInvalidStringBody { NvimStringBody },
      NvimInvalidStringQuote { NvimInvalidString },
      NvimInvalidStringSpecial { NvimStringSpecial },
      NvimInvalidSingleQuote { NvimInvalidStringQuote },
      NvimInvalidSingleQuotedBody { NvimInvalidStringBody },
      NvimInvalidSingleQuotedQuote { NvimInvalidStringSpecial },
      NvimInvalidDoubleQuote { NvimInvalidStringQuote },
      NvimInvalidDoubleQuotedBody { NvimInvalidStringBody },
      NvimInvalidDoubleQuotedEscape { NvimInvalidStringSpecial },
      NvimInvalidDoubleQuotedUnknownEscape { NvimInvalidValue },
      NvimInvalidFigureBrace { NvimInvalidDelimiter },
      NvimInvalidSpacing { ErrorMsg },
      NvimDoubleQuotedUnknownEscape { NvimInvalidValue },

      -- Telescope
      TelescopeSelection { fg = xres.color15, bg = xres.bg.lighten(5) },
      TelescopeSelectionCaret { fg = Special.fg, bg = TelescopeSelection.bg },
      TelescopeMultiSelection { Constant },
      TelescopeMultiIcon { TelescopeMultiSelection },
      TelescopeNormal { NormalFloat },
      TelescopePreviewNormal { NormalFloat },
      TelescopeBorder { FloatBorder },
      TelescopePromptBorder { TelescopeBorder },
      TelescopeResultsBorder { TelescopeBorder },
      TelescopePreviewBorder { TelescopeBorder },
      TelescopeMatching { Special },
      TelescopePromptPrefix { Special },
      TelescopePreviewLine { Visual },
      TelescopePreviewMatch { Search },
      TelescopePreviewPipe { Constant },
      TelescopePreviewCharDev { Constant },
      TelescopePreviewDirectory { Directory },
      TelescopePreviewBlock { Constant },
      TelescopePreviewLink { Special },
      TelescopePreviewSocket { Statement },
      TelescopePreviewRead { Constant },
      TelescopePreviewWrite { Statement },
      TelescopePreviewExecute { String },
      TelescopePreviewHyphen { NonText },
      TelescopePreviewSticky { Keyword },
      TelescopePreviewSize { String },
      TelescopePreviewUser { Constant },
      TelescopePreviewGroup { Constant },
      TelescopePreviewDate { Directory },
      TelescopePreviewMessage { TelescopePreviewNormal },
      TelescopePreviewMessageFillchar { TelescopePreviewMessage },
      TelescopeResultsClass { Function },
      TelescopeResultsNormal { fg = xres.color7 },
      TelescopeResultsConstant { Constant },
      TelescopeResultsField { Function },
      TelescopeResultsFunction { Function },
      TelescopeResultsMethod { Method },
      TelescopeResultsTitle { FloatTitle },
      TelescopePromptTitle { FloatTitle },
      TelescopePreviewTitle { FloatTitle },
      TelescopePromptCounter { Constant },

      TabLine { fg = xres.None, bg = xres.bg.lighten(2) },
      TabLineSel { StatusLine },
      TabLineFill { TabLine },

      NotifyERRORBorder { fg = hsl "#8A1F1F", bg = FloatBorder.bg },
      NotifyWARNBorder { fg = hsl "#79491D", bg = FloatBorder.bg },
      NotifyINFOBorder { fg = hsl "#4F6752", bg = FloatBorder.bg },
      NotifyDEBUGBorder { fg = hsl "#8B8B8B", bg = FloatBorder.bg },
      NotifyTRACEBorder { fg = hsl "#4F3552", bg = FloatBorder.bg },
      NotifyERRORIcon { fg = hsl "#F70067", bg = FloatBorder.bg },
      NotifyWARNIcon { fg = hsl "#F79000", bg = FloatBorder.bg },
      NotifyINFOIcon { fg = hsl "#A9FF68", bg = FloatBorder.bg },
      NotifyDEBUGIcon { fg = hsl "#8B8B8B", bg = FloatBorder.bg },
      NotifyTRACEIcon { fg = hsl "#D484FF", bg = FloatBorder.bg },
      NotifyERRORTitle { fg = hsl "#F70067", bg = FloatBorder.bg },
      NotifyWARNTitle { fg = hsl "#F79000", bg = FloatBorder.bg },
      NotifyINFOTitle { fg = hsl "#A9FF68", bg = FloatBorder.bg },
      NotifyDEBUGTitle { fg = hsl "#8B8B8B", bg = FloatBorder.bg },
      NotifyTRACETitle { fg = hsl "#D484FF", bg = FloatBorder.bg },
      NotifyERRORBody { NormalFloat },
      NotifyWARNBody { NormalFloat },
      NotifyINFOBody { NormalFloat },
      NotifyDEBUGBody { NormalFloat },
      NotifyTRACEBody { NormalFloat },

      -- crates.nvim
      CratesNvimLoading { fg = xres.fg.lighten(25), bg = xres.bg },
      CratesNvimPopupLoading { fg = xres.fg.lighten(25), bg = Pmenu.bg },
      CratesNvimVersion { fg = DiagnosticSignInfo.fg, bg = xres.bg },
      CratesNvimPopupVersion { fg = DiagnosticSignInfo.fg, bg = Pmenu.bg },
      CratesNvimPreRelease { fg = DiagnosticSignWarn.fg, bg = xres.bg },
      CratesNvimPopupPreRelease { fg = DiagnosticSignWarn.fg, bg = Pmenu.bg },
      CratesNvimYanked { fg = DiagnosticSignError.fg, bg = xres.bg },
      CratesNvimPopupYanked { fg = DiagnosticSignError.fg, bg = Pmenu.bg },
      CratesNvimNoMatch { fg = DiagnosticSignWarn.fg, bg = xres.bg.lighten(15) },
      CratesNvimUpgrade { fg = GitSignsAdd.fg, bg = xres.bg.lighten(15) },
      CratesNvimError { fg = DiagnosticSignError.fg, bg = xres.bg.lighten(15) },

      -- tree sitter
      sym "@comment" { fg = xres.bg.lighten(40), bg = xres.none },
      sym "@comment.documentation" { Special },
      sym "@punctuation" { fg = xres.color15.darken(10), bg = xres.none },
      sym "@variable.field" { fg = Identifier.fg.ro(15).darken(20), bg = xres.none },
      sym "@function.builtin" { Function, gui = "italic" },
      sym "@constructor" { Function, gui = "bold" },
      sym "@lsp.type.property" { fg = Identifier.fg.lighten(50), bg = xres.none },
      sym "@lsp.type.class" { fg = Structure.fg, bg = xres.none, gui = "bold" },
      sym "@lsp.type.struct" { fg = Type.fg, bg = xres.none, gui = "bold" },
      sym "@lsp.type.interface" { fg = Constant.fg.ro(20).lighten(40), bg = xres.none, gui = "bold" },

      -- cmp completion
      CmpItemMenu { fg = Title.fg, bg = xres.none, gui = "italic" },
      CmpItemKindEvent { bg = xres.none, fg = NotifyWARNIcon.fg, gui = "bold" },
      CmpItemKindFile { bg = xres.none, fg = NeoTreeFileIcon.fg, gui = "bold" },
      CmpItemKindFolder { bg = xres.none, fg = NeoTreeDirectoryIcon.fg, gui = "bold" },
      CmpItemKindClass { bg = xres.none, fg = sym("@lsp.type.class").fg, gui = "bold" },
      CmpItemKindStruct { bg = xres.none, fg = sym("@lsp.type.struct").fg, gui = "bold" },
      CmpItemKindEnum { bg = xres.none, fg = sym("@lsp.type.struct").fg, gui = "bold" },
      CmpItemKindEnumMember { bg = xres.none, fg = Constant.fg, gui = "bold" },
      CmpItemKindInterface { bg = xres.none, fg = sym("@lsp.type.interface").fg, gui = "bold" },
      CmpItemKindModule { bg = xres.none, fg = Structure.fg.lighten(10), gui = "bold" },
      CmpItemKindText { bg = xres.none, fg = String.fg, gui = "bold" },
      CmpItemKindColor { bg = xres.none, fg = Tag.fg, gui = "bold" },
      CmpItemKindKeyword { bg = xres.none, fg = Keyword.fg, gui = "bold" },
      CmpItemKindMethod { bg = xres.none, fg = sym("@function.builtin").fg, gui = "bold" },
      CmpItemKindConstructor { bg = xres.none, fg = sym("@constructor").fg, gui = "bold" },
      CmpItemKindFunction { bg = xres.none, fg = Function.fg, gui = "bold" },
      CmpItemKindOperator { bg = xres.none, fg = Operator.fg, gui = "bold" },
      CmpItemKindReference { bg = xres.none, fg = Label.fg, gui = "bold" },
      CmpItemKindSnippet { bg = xres.none, fg = SpecialKey.fg, gui = "bold" },
      CmpItemKindField { bg = xres.none, fg = sym("@variable.field").fg, gui = "bold" },
      CmpItemKindProperty { bg = xres.none, fg = sym("@lsp.type.property").fg, gui = "bold" },
      CmpItemKindUnit { bg = xres.none, fg = Function.fg, gui = "bold" },
      CmpItemKindValue { bg = xres.none, fg = Number.fg, gui = "bold" },
      CmpItemKindVariable { bg = xres.none, fg = Identifier.fg, gui = "bold" },
      CmpItemKindConstant { bg = xres.none, fg = Constant.fg, gui = "bold" },
      CmpItemKindTypeParameter { bg = xres.none, fg = Typedef.fg, gui = "bold" },

      ContextVt { NonText },
      NeoTreeFloatTitle { FloatTitle },
      NeogitCommitViewHeader { fg = xres.color9, bg = xres.color8, gui = "bold" },

      DapUIFrameName { Normal },
      DapUIValue { Normal },
      DapUIVariable { Normal },
      DapUIStopNC { fg = DiagnosticError.fg, bg = xres.color8 },
      DapUIStop { DapUIStopNC },
      DapUIResetNC { DapUIStopNC },
      DapUIReset { DapUIResetNC },
      DapUIPlayPauseNC { fg = GitSignsAdd.fg, bg = xres.color8 },
      DapUIPlayPause { DapUIPlayPauseNC },
      DapUIRestartNC { DapUIPlayPauseNC },
      DapUIRestart { DapUIRestartNC },
      DapUIStepIntoNC { fg = DiagnosticWarn.fg, bg = xres.color8 },
      DapUIStepInto { DapUIStepIntoNC },
      DapUIStepBackNC { DapUIStepIntoNC },
      DapUIStepBack { DapUIStepBackNC },
      DapUIStepOutNC { DapUIStepIntoNC },
      DapUIStepOut { DapUIStepOutNC },
      DapUIStepOverNC { DapUIStepIntoNC },
      DapUIStepOver { DapUIStepOverNC },

      WindowPickerStatusLine { bg = StatusLine.bg.lighten(10) },
      WindowPickerStatusLineNC { bg = StatusLineNC.bg.lighten(10) },

      MiniStatuslineModeNormal { bg = xres.color9, fg = xres.bg, gui = "bold" },
      MiniStatuslineModeInsert { bg = xres.color10, fg = xres.bg, gui = "bold" },
      MiniStatuslineModeVisual { bg = xres.color11, fg = xres.bg, gui = "bold" },
      MiniStatuslineModeReplace { bg = xres.color12, fg = xres.bg, gui = "bold" },
      MiniStatuslineModeCommand { bg = MiniStatuslineModeNormal.bg.darken(10), fg = xres.bg, gui = "bold" },
      MiniStatuslineModeOther { bg = MiniStatuslineModeCommand.bg, fg = MiniStatuslineModeCommand.fg, gui = "bold" },
    }
  end)

  lush(theme)
end)
