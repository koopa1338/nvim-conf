local walush = nil

-- set font for gui mode
vim.opt.guifont = "Inconsolata Nerd Font Mono:h14"

Get_theme_hl = function(name)
  local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
  if not ok then
    return
  end
  for _, key in pairs { "foreground", "background", "special" } do
    if hl[key] then
      hl[key] = string.format("#%06x", hl[key])
    end
  end
  return hl
end

local xres = table.clone(Colors_or_default())
xres.diffgreen = "#002800"
xres.diffred = "#3f0000"
xres.diffyellow = "#3f3f00"

L("lush", function(lush)
  local hsl = lush.hsl
  for name, color in pairs(xres) do
    xres[name] = hsl(color)
  end
  xres.none = "NONE"

  ---@diagnostic disable: undefined-global, undefined-field
  walush = lush(function(injected_functions)
    -- you probably want to alias it locally
    local sym = injected_functions.sym
    return {
      -- git
      DiffAdd { fg = xres.None, bg = xres.diffgreen },
      DiffDelete { fg = xres.None, bg = xres.diffred },
      DiffChange { fg = xres.None, bg = xres.diffyellow },
      DiffText { fg = xres.None, bg = DiffAdd.bg.lighten(2.5) },

      -- Diagnostics
      DiagnosticError { fg = DiffDelete.bg.lighten(35) },
      DiagnosticWarn { fg = DiffChange.bg.lighten(35) },
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
      Type { fg = xres.color13, bg = xres.bg, gui = "bold" },
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
      DapUIFrameName { Normal },
      DapUIValue { Normal },
      DapUIVariable { Normal },
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
      Function { fg = xres.color15, bg = xres.bg },
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
      Typedef { fg = xres.color10, bg = xres.color8 },
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
      GitSignsChange { fg = DiffChange.bg.lighten(30) },
      GitSignsChangeNr { fg = GitSignsChange.fg },
      GitSignsCurrentLineBlame { fg = NonText.fg.lighten(10) },

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

      NvimTreeWindowPicker { FloatTitle },
      NvimTreePopup { Normal },
      NvimTreeNormal { Normal },
      NvimTreeSpecialFile { fg = xres.color10, gui = "bold,underline" },
      NvimTreeGitDeleted { diffOldFile },
      NvimTreeGitNew { diffNewFile },
      NvimTreeGitMerge { fg = xres.color12 },
      NvimTreeSymlink { fg = xres.color11, gui = "bold" },
      NvimTreeRootFolder { fg = xres.color7 },
      NvimTreeGitDirty { fg = xres.color13 },
      NvimTreeSignColumn { NvimTreeNormal },
      NvimTreeFileNew { NvimTreeGitNew },
      NvimTreeFileDeleted { NvimTreeGitDeleted },
      NvimTreeVertSplit { VertSplit },
      NvimTreeFileMerge { NvimTreeGitMerge },
      NvimTreeFolderName { Directory },
      NvimTreeStatusLineNC { StatusLineNC },
      NvimTreeStatusLine { StatusLine },
      NvimTreeCursorLine { CursorLine },
      NvimTreeGitIgnored { Comment },
      NvimTreeEndOfBuffer { EndOfBuffer },
      NvimTreeFileDirty { NvimTreeGitDirty },
      NvimTreeNormalNC { NvimTreeNormal },
      NvimTreeOpenedFolderName { Directory },
      NvimTreeEmptyFolderName { Directory },
      NvimTreeCursorColumn { CursorColumn },
      NvimTreeLspDiagnosticsError { DiagnosticError },
      NvimTreeLspDiagnosticsWarning { DiagnosticWarning },
      NvimTreeLspDiagnosticsInformation { DiagnosticInfo },
      NvimTreeLspDiagnosticsHint { DiagnosticHint },

      -- Telescope
      TelescopeSelection { fg = xres.color7, bg = xres.bg.lighten(5) },
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
      TelescopeResultsConstant { Constant },
      TelescopeResultsField { Function },
      TelescopeResultsFunction { Function },
      TelescopeResultsMethod { Method },
      TelescopeResultsTitle { FloatTitle },
      TelescopePromptTitle { FloatTitle },
      TelescopePreviewTitle { FloatTitle },
      TelescopePromptCounter { Constant },

      -- Devicons
      DevIconDiff { fg = hsl "#41535b" },
      DevIconElm { fg = hsl "#519aba" },
      DevIconJl { fg = hsl "#a270ba" },
      DevIconSass { fg = hsl "#f55385" },
      DevIconXcPlayground { fg = hsl "#e37933" },
      DevIconSln { fg = hsl "#854CC7" },
      DevIconR { fg = hsl "#358a5b" },
      DevIconZshrc { fg = hsl "#89e051" },
      DevIconTex { fg = hsl "#3D6117" },
      DevIconTor { fg = hsl "#519aba" },
      DevIconJsx { fg = hsl "#519aba" },
      DevIconJson { fg = hsl "#cbcb41" },
      DevIconPl { fg = hsl "#519aba" },
      DevIconMl { fg = hsl "#e37933" },
      DevIconMarkdown { fg = hsl "#519aba" },
      DevIconCp { fg = hsl "#519aba" },
      DevIconRmd { fg = hsl "#519aba" },
      DevIconZsh { fg = hsl "#89e051" },
      DevIconCrystal { fg = hsl "#000000" },
      DevIconIni { fg = hsl "#6d8086" },
      DevIconPyc { fg = hsl "#519aba" },
      DevIconCpp { fg = hsl "#519aba" },
      DevIconGitConfig { fg = hsl "#41535b" },
      DevIconProcfile { fg = hsl "#a074c4" },
      DevIconDesktopEntry { fg = hsl "#563d7c" },
      DevIconFsscript { fg = hsl "#519aba" },
      DevIconClojure { fg = hsl "#8dc149" },
      DevIconBashrc { fg = hsl "#89e051" },
      DevIconErb { fg = hsl "#701516" },
      DevIconEx { fg = hsl "#a074c4" },
      DevIconMli { fg = hsl "#e37933" },
      DevIconSvelte { fg = hsl "#ff3e00" },
      DevIconC { fg = hsl "#599eff" },
      DevIconEjs { fg = hsl "#cbcb41" },
      DevIconJava { fg = hsl "#cc3e44" },
      DevIconEdn { fg = hsl "#519aba" },
      DevIconGruntfile { fg = hsl "#e37933" },
      DevIconSvg { fg = hsl "#FFB13B" },
      DevIconXul { fg = hsl "#e37933" },
      DevIconDart { fg = hsl "#03589C" },
      DevIconCMake { fg = hsl "#6d8086" },
      DevIconMustache { fg = hsl "#e37933" },
      DevIconHxx { fg = hsl "#a074c4" },
      DevIconYaml { fg = hsl "#6d8086" },
      DevIconCobol { fg = hsl "#005ca5" },
      DevIconCPlusPlus { fg = hsl "#f34b7d" },
      DevIconGitLogo { fg = hsl "#F14C28" },
      DevIconJpeg { fg = hsl "#a074c4" },
      DevIconWebpack { fg = hsl "#519aba" },
      DevIconVimrc { fg = hsl "#019833" },
      DevIconHtml { fg = hsl "#e34c26" },
      DevIconDoc { fg = hsl "#185abd" },
      DevIconSwift { fg = hsl "#e37933" },
      DevIconLess { fg = hsl "#563d7c" },
      DevIconGemspec { fg = hsl "#701516" },
      DevIconStyl { fg = hsl "#8dc149" },
      DevIconBmp { fg = hsl "#a074c4" },
      DevIconLhs { fg = hsl "#a074c4" },
      DevIconSlim { fg = hsl "#e34c26" },
      DevIconScala { fg = hsl "#cc3e44" },
      DevIconTerminal { fg = hsl "#31B53E" },
      DevIconGemfile { fg = hsl "#701516" },
      DevIconGulpfile { fg = hsl "#cc3e44" },
      DevIconCoffee { fg = hsl "#cbcb41" },
      DevIconAi { fg = hsl "#cbcb41" },
      DevIconDefault { fg = hsl "#6d8086" },
      DevIconLua { fg = hsl "#51a0cf" },
      DevIconGif { fg = hsl "#a074c4" },
      DevIconVagrantfile { fg = hsl "#1563FF" },
      DevIconJpg { fg = hsl "#a074c4" },
      DevIconMdx { fg = hsl "#519aba" },
      DevIconIco { fg = hsl "#cbcb41" },
      DevIconFsharp { fg = hsl "#519aba" },
      DevIconHpp { fg = hsl "#a074c4" },
      DevIconHaml { fg = hsl "#eaeae1" },
      DevIconNPMIgnore { fg = hsl "#E8274B" },
      DevIconKsh { fg = hsl "#4d5a5e" },
      DevIconZshprofile { fg = hsl "#89e051" },
      DevIconGitModules { fg = hsl "#41535b" },
      DevIconLicense { fg = hsl "#cbcb41" },
      DevIconXls { fg = hsl "#207245" },
      DevIconAwk { fg = hsl "#4d5a5e" },
      DevIconGo { fg = hsl "#519aba" },
      DevIconXml { fg = hsl "#e37933" },
      DevIconNix { fg = hsl "#7ebae4" },
      DevIconGvimrc { fg = hsl "#019833" },
      DevIconTextScene { fg = hsl "#a074c4" },
      DevIconRs { fg = hsl "#dea584" },
      DevIconPhp { fg = hsl "#a074c4" },
      DevIconHtm { fg = hsl "#e34c26" },
      DevIconPm { fg = hsl "#519aba" },
      DevIconClojureC { fg = hsl "#8dc149" },
      DevIconHeex { fg = hsl "#a074c4" },
      DevIconDockerfile { fg = hsl "#384d54" },
      DevIconMjs { fg = hsl "#f1e05a" },
      DevIconCson { fg = hsl "#cbcb41" },
      DevIconDsStore { fg = hsl "#41535b" },
      DevIconImportConfiguration { fg = hsl "#ECECEC" },
      DevIconGitIgnore { fg = hsl "#41535b" },
      DevIconMixLock { fg = hsl "#a074c4" },
      DevIconDropbox { fg = hsl "#0061FE" },
      DevIconMd { fg = hsl "#519aba" },
      DevIconClojureJS { fg = hsl "#519aba" },
      DevIconPpt { fg = hsl "#cb4a32" },
      DevIconRss { fg = hsl "#FB9D3B" },
      DevIconCs { fg = hsl "#596706" },
      DevIconExs { fg = hsl "#a074c4" },
      DevIconEex { fg = hsl "#a074c4" },
      DevIconBat { fg = hsl "#C1F12E" },
      DevIconProlog { fg = hsl "#e4b854" },
      DevIconJs { fg = hsl "#cbcb41" },
      DevIconVue { fg = hsl "#8dc149" },
      DevIconHs { fg = hsl "#a074c4" },
      DevIconBashProfile { fg = hsl "#89e051" },
      DevIconZig { fg = hsl "#f69a1b" },
      DevIconBinaryGLTF { fg = hsl "#FFB13B" },
      DevIconDump { fg = hsl "#dad8d8" },
      DevIconCss { fg = hsl "#563d7c" },
      DevIconNodeModules { fg = hsl "#E8274B" },
      DevIconPsb { fg = hsl "#519aba" },
      DevIconTextResource { fg = hsl "#cbcb41" },
      DevIconZshenv { fg = hsl "#89e051" },
      DevIconConfigRu { fg = hsl "#701516" },
      DevIconOpenTypeFont { fg = hsl "#ECECEC" },
      DevIconFs { fg = hsl "#519aba" },
      DevIconRake { fg = hsl "#701516" },
      DevIconWebmanifest { fg = hsl "#f1e05a" },
      DevIconFsx { fg = hsl "#519aba" },
      DevIconRproj { fg = hsl "#358a5b" },
      DevIconRlib { fg = hsl "#dea584" },
      DevIconGodotProject { fg = hsl "#6d8086" },
      DevIconMaterial { fg = hsl "#B83998" },
      DevIconPyd { fg = hsl "#519aba" },
      DevIconPy { fg = hsl "#3572A5" },
      DevIconD { fg = hsl "#427819" },
      DevIconPsd { fg = hsl "#519aba" },
      DevIconLeex { fg = hsl "#a074c4" },
      DevIconH { fg = hsl "#a074c4" },
      DevIconFavicon { fg = hsl "#cbcb41" },
      DevIconPromptPs1 { fg = hsl "#4d5a5e" },
      DevIconPp { fg = hsl "#302B6D" },
      DevIconBash { fg = hsl "#89e051" },
      DevIconPng { fg = hsl "#a074c4" },
      DevIconWebp { fg = hsl "#a074c4" },
      DevIconConf { fg = hsl "#6d8086" },
      DevIconDb { fg = hsl "#dad8d8" },
      DevIconGDScript { fg = hsl "#6d8086" },
      DevIconVim { fg = hsl "#019833" },
      DevIconErl { fg = hsl "#B83998" },
      DevIconBabelrc { fg = hsl "#cbcb41" },
      DevIconHrl { fg = hsl "#B83998" },
      DevIconPdf { fg = hsl "#b30b00" },
      DevIconRakefile { fg = hsl "#701516" },
      DevIconRb { fg = hsl "#701516" },
      DevIconGitlabCI { fg = hsl "#e24329" },
      DevIconScss { fg = hsl "#f55385" },
      DevIconSh { fg = hsl "#4d5a5e" },
      DevIconSml { fg = hsl "#e37933" },
      DevIconSql { fg = hsl "#dad8d8" },
      DevIconConfiguration { fg = hsl "#ECECEC" },
      DevIconSuo { fg = hsl "#854CC7" },
      DevIconMakefile { fg = hsl "#6d8086" },
      DevIconHh { fg = hsl "#a074c4" },
      DevIconYml { fg = hsl "#6d8086" },
      DevIconPyo { fg = hsl "#519aba" },
      DevIconGitAttributes { fg = hsl "#41535b" },
      DevIconSettingsJson { fg = hsl "#854CC7" },
      DevIconCsh { fg = hsl "#4d5a5e" },
      DevIconFish { fg = hsl "#4d5a5e" },
      DevIconToml { fg = hsl "#6d8086" },
      DevIconCMakeLists { fg = hsl "#6d8086" },
      DevIconFsi { fg = hsl "#519aba" },
      DevIconCxx { fg = hsl "#519aba" },
      DevIconKotlin { fg = hsl "#F88A02" },
      DevIconGitCommit { fg = hsl "#41535b" },
      DevIconPackedResource { fg = hsl "#6d8086" },
      DevIconSig { fg = hsl "#e37933" },
      DevIconOPUS { fg = hsl "#F88A02" },
      DevIconHbs { fg = hsl "#f0772b" },
      DevIconTwig { fg = hsl "#8dc149" },
      DevIconTs { fg = hsl "#519aba" },
      DevIconTsx { fg = hsl "#519aba" },

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

      -- cmp completion
      CmpItemMenu { fg = Title.fg, bg = xres.none, gui = "italic" },
      CmpItemKindClass { fg = "#FFFFFF", bg = DevIconGulpfile.fg, gui = "bold" },
      CmpItemKindStruct { fg = "#FFFFFF", bg = DevIconGulpfile.fg, gui = "bold" },
      CmpItemKindEnum { fg = "#FFFFFF", bg = DevIconGulpfile.fg, gui = "bold" },
      CmpItemKindEnumMember { fg = "#FFFFFF", bg = DevIconGulpfile.fg, gui = "bold" },
      CmpItemKindInterface { fg = "#FFFFFF", bg = DevIconGulpfile.fg, gui = "bold" },
      CmpItemKindModule { fg = "#FFFFFF", bg = DevIconGulpfile.fg, gui = "bold" },
      CmpItemKindText { fg = "#FFFFFF", bg = DevIconDefault.fg, gui = "bold" },
      CmpItemKindColor { fg = "#FFFFFF", bg = DevIconDefault.fg, gui = "bold" },
      CmpItemKindEvent { fg = "#FFFFFF", bg = DevIconLess.fg, gui = "bold" },
      CmpItemKindFile { fg = "#FFFFFF", bg = DevIconLess.fg, gui = "bold" },
      CmpItemKindFolder { fg = "#FFFFFF", bg = DevIconLess.fg, gui = "bold" },
      CmpItemKindKeyword { fg = "#FFFFFF", bg = DevIconDoc.fg, gui = "bold" },
      CmpItemKindMethod { fg = "#FFFFFF", bg = DevIconDoc.fg, gui = "bold" },
      CmpItemKindConstructor { fg = "#FFFFFF", bg = DevIconDoc.fg, gui = "bold" },
      CmpItemKindFunction { fg = "#FFFFFF", bg = DevIconDoc.fg, gui = "bold" },
      CmpItemKindOperator { fg = "#FFFFFF", bg = DevIconFssScript.fg, gui = "bold" },
      CmpItemKindReference { fg = "#FFFFFF", bg = DevIconFssScript.fg, gui = "bold" },
      CmpItemKindSnippet { fg = "#FFFFFF", bg = SpecialKey.fg, gui = "bold" },
      CmpItemKindField { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
      CmpItemKindProperty { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
      CmpItemKindUnit { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
      CmpItemKindValue { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
      CmpItemKindVariable { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
      CmpItemKindConstant { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
      CmpItemKindTypeParameter { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },

      ContextVt { NonText },
      NeoTreeFloatTitle { FloatTitle },
      NeogitCommitViewHeader { fg = xres.color9, bg = xres.color8, gui = "bold" },

      -- tree sitter
      sym "@comment" { fg = xres.bg.lighten(40), bg = xres.none },
      sym "@comment.documentation" { Special },
      sym "@punctuation" { fg = xres.color15.darken(10), bg = xres.none },
    }
  end)

  lush(walush)
end)
